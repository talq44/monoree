//
//  TabsView.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import UIKit

public class TabsView: UIView {
    public typealias State = TabsViewState
    
    private enum Metric {
        static let height: CGFloat = 48
        static let bottomLineHeight: CGFloat = 2
        static func itemWidth(_ itemsCount: Int) -> CGFloat {
            return UIScreen.main.bounds.width / CGFloat(itemsCount)
        }
    }
    
    static public var height = Metric.height
    
    private let stackView = UIStackView()
    private var tabButtons: [UIButton] = []
    private let bottomLineView = UIView()
    
    private var bottomLineLeading: NSLayoutConstraint?
    
    public var didSelectedItem: ((Int) -> Void)?
    
    public init(state: State? = nil, frame: CGRect = .zero) {
        super.init(frame: frame)
        if let state {
            self.setUpList(state: state)
        }
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addConfigure()
        self.makeConstriansts()
    }
    
    private func addConfigure() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .fillEqually
        self.bottomLineView.backgroundColor = .systemOrange
    }
    
    private func makeConstriansts() {
        self.addSubview(stackView)
        self.addSubview(bottomLineView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        let leadingBottomLine = self.bottomLineView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        )
        
        NSLayoutConstraint.activate([
            // stackview
            self.stackView.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Metric.bottomLineHeight
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            self.stackView.heightAnchor.constraint(
                equalToConstant: Metric.height
            ),
            leadingBottomLine,
            self.bottomLineView.widthAnchor.constraint(
                equalToConstant: Metric.itemWidth(self.tabButtons.count)
            ),
            self.bottomLineView.heightAnchor.constraint(
                equalToConstant: Metric.bottomLineHeight
            ),
            self.bottomLineView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
        ])
        
        self.bottomLineLeading = leadingBottomLine
    }
    
    private func setUpList(state: State) {
        self.tabButtons.forEach {
            self.stackView.removeArrangedSubview($0)
        }
        self.tabButtons.removeAll()
        
        let newButtons = state.items.enumerated().map { index, item in
            let button = UIButton()
            button.setTitle(item.title, for: .normal)
            button.setTitleColor(UIColor.quaternaryLabel, for: .normal)
            button.setTitleColor(UIColor.label, for: .selected)
            button.isSelected = item.isSelected
            
            let action = UIAction { [weak self] _ in
                self?.selectItem(at: index)
                guard let compltion = self?.didSelectedItem else { return }
                compltion(index)
            }
            button.addAction(action, for: .touchUpInside)
            return button
        }
        
        // 단 하나만 선택되도록. 이럴거면 collectionView로 할걸
        let allSelected = state.items.allSatisfy { $0.isSelected == true }
        let allDeSelected = state.items.allSatisfy { $0.isSelected == false }
        let selectedCount = state.items.filter { $0.isSelected }.count
        
        if allSelected || allDeSelected {
            newButtons.forEach { $0.isSelected = false }
            newButtons.first?.isSelected = true
        } else if selectedCount > 1 {
            let index = state.items.enumerated()
                .filter { $0.element.isSelected }
                .map { $0.offset }
                .first ?? 0
            newButtons.forEach { $0.isSelected = false }
            newButtons[index].isSelected = true
        }
        
        newButtons.forEach { self.stackView.addArrangedSubview($0) }
        self.tabButtons = newButtons
        self.moveBottomLine(to: 0)
    }
    
    private func moveBottomLine(to index: Int) {
        guard tabButtons.count > index else { return }
        let leading = CGFloat(index) * Metric.itemWidth(self.tabButtons.count)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.bottomLineLeading?.constant = leading
            self?.layoutIfNeeded()
        }
    }
    
    public func selectItem(at index: Int) {
        guard tabButtons.count > index else { return }
        self.tabButtons.enumerated().filter { $0.offset != index }
            .map { $0.element }
            .forEach { $0.isSelected = false }
        self.tabButtons.enumerated().filter { $0.offset == index }
            .map { $0.element }
            .forEach { $0.isSelected = true }
        
        self.moveBottomLine(to: index)
    }
}

@available(iOS 17.0, *)
#Preview("2Item") {
    let view = TabsView(state: .mock2Item)
    return view
}

@available(iOS 17.0, *)
#Preview("4Item") {
    let view = TabsView(state: .mock4Item)
    return view
}
