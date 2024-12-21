import UIKit

import FoundationShared

final public class ListView: UIView {
    public typealias State = [ListItem]
    typealias Cell = ListViewCell
    
    private enum Metric {
        static func headerHeight(style: UITableView.Style) -> CGFloat {
            switch style {
            case .grouped:
                return 30
            default:
                return 0
            }
        }
        static let horizontalPadding: CGFloat = .horizontalMargin
    }
    
    private let tableView: UITableView
    private let refreshControl = UIRefreshControl()
    private var refreshClosetimer: Timer?
    
    private var items: [[ListItem]] = []
    
    public var didSelectRowAtId: ((_ id: Int) -> Void)?
    public var didSelectBookmarkAtId: ((_ id: Int) -> Void)?
    public var didRefresh: (() -> Void)?
    public var willDisplayLast: (() -> Void)?
    
    public init(
        style: UITableView.Style = .plain,
        frame: CGRect = .zero
    ) {
        self.tableView = UITableView(frame: frame, style: style)
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addConfigure()
        self.makeConstraints()
    }
    
    private func addConfigure() {
        self.tableView.registCell(type: Cell.self)
        self.tableView.rowHeight = Cell.height
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.keyboardDismissMode = .onDrag
        
        self.tableView.sectionHeaderHeight = Metric.headerHeight(
            style: self.tableView.style
        )
        self.tableView.sectionFooterHeight = 0
        
        let refreshAction = UIAction { [weak self] _ in
            self?.refreshControl.beginRefreshing()
            if let refreshClosetimer = self?.refreshClosetimer {
                refreshClosetimer.invalidate()
            }
            
            self?.refreshClosetimer = Timer.scheduledTimer(
                withTimeInterval: 5.0,
                repeats: false,
                block: { timer in
                    timer.invalidate()
                    self?.refreshControl.endRefreshing()
                }
            )
            
            guard let refresh = self?.didRefresh else { return }
            refresh()
        }
        self.refreshControl.addAction(refreshAction, for: .valueChanged)
    }
    
    private func makeConstraints() {
        self.addSubview(tableView)
        self.tableView.addSubview(refreshControl)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // stackview
            self.tableView.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            self.tableView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
            self.tableView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            self.tableView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
        ])
    }
    
    public func bind(state: State) {
        self.refreshControl.endRefreshing()
        self.setDatas(state: state)
    }
    
    private func setDatas(state: State) {
        guard [state] != items else { return }
        self.items = state.map { [$0] }
        switch self.tableView.style {
        case .plain:
            self.items = [state]
            
        case .grouped:
            self.items = self.chosungSorted(state)
            
        case .insetGrouped:
            self.items = [state]
            
        @unknown default:
            self.items = [state]
        }
        
        self.tableView.reloadData()
    }
    
    private func chosungSorted(_ array: [ListItem]) -> [[ListItem]] {
        
        var groupedDict: [String: [ListItem]] = [:]
        
        for item in array {
            let chosung = item.name.chosung()
            if groupedDict[chosung] == nil {
                groupedDict[chosung] = []
            }
            groupedDict[chosung]?.append(item)
        }
        
        return groupedDict
            .sorted { $0.key < $1.key }
            .map { $0.value }
    }
}

extension ListView: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard tableView.style == .grouped else {
            return nil
        }
        let titleLabel = DSLabel(style: .title2)
        let view = UIView()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(
            equalTo: view.centerYAnchor
        ).isActive = true
        titleLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: Metric.horizontalPadding
        ).isActive = true
        titleLabel.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -Metric.horizontalPadding
        ).isActive = true
        let chosung = self.items[section].first?.name.chosung()
        titleLabel.text = "\(chosung ?? "")"
        return view
    }
    
    public func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return self.items.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.items[section].count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(
            withType: Cell.self,
            for: indexPath
        ) else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        
        let sections = self.items[safe: indexPath.section]
        guard let state = sections?[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.bind(state: state)
        cell.didSelectBookmark = { [weak self] in
            guard let didSelectBookmarkAtId = self?.didSelectBookmarkAtId else {
                return
            }
            didSelectBookmarkAtId(state.id)
        }
        
        return cell
    }
}

extension ListView: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let didSelectRowAtId else {
            return
        }
        
        let sections = self.items[safe: indexPath.section]
        guard let state = sections?[safe: indexPath.row] else {
            return
        }
        
        didSelectRowAtId(state.id)
    }
    
    public func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard indexPath.row > 0 else { return }
        guard indexPath.section == self.items.count - 1 else { return }
        let lastItems = self.items[indexPath.section]
        guard indexPath.row == lastItems.count - 1 else { return}
        guard let willDisplayLast else { return }
        willDisplayLast()
    }
}

@available(iOS 17.0, *)
#Preview("normal") {
    let view = ListView()
    let items = Array(1..<100).map {
        ListItem.mock(id: $0)
    }
    view.bind(state: items)
    return view
}
