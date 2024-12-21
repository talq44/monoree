//
//  ListViewCell.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import UIKit

class ListViewCell: UITableViewCell {
    typealias ItemView = ListItemView
    
    private enum Metric {
        static let verticalInset: CGFloat = 8
        static let horizontalInset: CGFloat = 16
    }
    
    static let height: CGFloat = ItemView.height + (Metric.verticalInset * 2)
    private let itemView = ItemView(type: .normal)
    
    public var didSelectBookmark: (() -> Void)? {
        didSet {
            self.itemView.didSelectBookmark = self.didSelectBookmark
        }
    }
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.didSelectBookmark = nil
    }
    
    private func initView() {
        self.makeConstraints()
    }
    
    private func makeConstraints() {
        self.contentView.addSubview(itemView)
        self.itemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // stackview
            self.itemView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: Metric.verticalInset
            ),
            self.itemView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -Metric.verticalInset
            ),
            self.itemView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: Metric.horizontalInset
            ),
            self.itemView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -Metric.horizontalInset
            ),
        ])
    }
    
    internal func bind(state: ListItem) {
        self.itemView.bind(state: state)
    }
}
