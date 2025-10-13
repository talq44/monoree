import UIKit
import UIKitExtensionShared
import SnapKit

final class GameListViewController: BaseViewController {
    private enum Metric {
        static let itemHeight: CGFloat = 60
        static let itemSpacing: CGFloat = Spacing.m
    }
    
    private let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.rowHeight = Metric.itemHeight
        tableView.separatorStyle = .none
        tableView.register(GameListItemCell.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
