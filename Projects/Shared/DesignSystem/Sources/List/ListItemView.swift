//
//  ListItemView.swift
//  DesignSystem
//
//  Created by 박창규 on 11/30/24.
//

import UIKit

public class ListItemView: UIView {
    public typealias State = ListItem
    
    private enum Metric {
        static let height: CGFloat = 48
        static let itemSpacing: CGFloat = 8
        static let imageSize = CGSize(width: 48, height: height)
        static let bookmarkSize = CGSize(width: 48, height: height)
    }
    
    public static let height: CGFloat = Metric.height
    
    private let stackView = UIStackView()
    private let imageView = ThumbnailsView()
    private let titleLabel = DSLabel(style: .title3)
    private let bookmarkButton = UIButton()
    
    public var didSelectBookmark: (() -> Void)?
    
    public init(type: ListItemType, frame: CGRect = .zero) {
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
        self.addConfigureStackView()
        self.addConfigureButton()
    }
    
    private func addConfigureStackView() {
        self.stackView.axis = .horizontal
        self.stackView.spacing = Metric.itemSpacing
        self.stackView.alignment = .center
    }
    
    private func addConfigureButton() {
        let bookmarkAction = UIAction { [weak self] _ in
            guard let completion = self?.didSelectBookmark else { return }
            completion()
        }
        self.bookmarkButton.addAction(bookmarkAction, for: .touchUpInside)
        self.bookmarkButton.setImage(
            UIImage(systemName: "bookmark"),
            for: .normal
        )
        self.bookmarkButton.setImage(
            UIImage(systemName: "bookmark.fill"),
            for: .selected
        )
    }
    
    private func makeConstraints() {
        self.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // stackview
            self.stackView.topAnchor.constraint(
                equalTo: self.topAnchor
            ),
            self.stackView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
            self.stackView.heightAnchor.constraint(
                equalToConstant: Metric.height
            ),
            self.stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            self.stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            // imageView
            self.imageView.widthAnchor.constraint(
                equalToConstant: Metric.imageSize.width
            ),
            self.imageView.heightAnchor.constraint(
                equalToConstant: Metric.imageSize.height
            ),
            // bookmarkButton
            self.bookmarkButton.widthAnchor.constraint(
                equalToConstant: Metric.bookmarkSize.width
            ),
            self.bookmarkButton.heightAnchor.constraint(
                equalToConstant: Metric.bookmarkSize.height
            )
        ])
        
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(UIView())
        self.stackView.addArrangedSubview(bookmarkButton)
    }
    
    public func bind(state: State) {
        self.imageView.setImage(state.imageURL)
        self.titleLabel.text = state.name
        self.bookmarkButton.isSelected = state.isBookmarked
    }
}

@available(iOS 17.0, *)
#Preview("bookMarked") {
    let view = ListItemView(type: .normal)
    view.bind(state: ListItem(
        id: 1,
        imageURL: "https://avatars.githubusercontent.com/u/12158001?v=4",
        name: "bookMarked",
        isBookmarked: true
    ))
    view.didSelectBookmark = { print("didSelectBookmark") }
    return view
}

@available(iOS 17.0, *)
#Preview("no bookMarked") {
    let view = ListItemView(type: .normal)
    view.bind(state: ListItem(
        id: 1,
        imageURL: "https://avatars.githubusercontent.com/u/12158001?v=4",
        name: "no bookMarked",
        isBookmarked: false
    ))
    return view
}

@available(iOS 17.0, *)
#Preview("long Name") {
    let view = ListItemView(type: .normal)
    view.bind(state: ListItem(
        id: 1,
        imageURL: "https://avatars.githubusercontent.com/u/12158001?v=4",
        name: String(repeating: "안녕하세요", count: 10),
        isBookmarked: false
    ))
    return view
}
