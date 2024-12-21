//
//  EmptyView.swift
//  DesignSystem
//
//  Created by 박창규 on 11/29/24.
//

import UIKit

final public class EmptyView: UIView {
    
    private enum Metric {
        static let itemSpacing: CGFloat = 8
        static let imageSize = CGSize(width: 48, height: 48)
        static let centerOffset: CGFloat = -56
    }

    private let type: EmptyViewType
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = DSLabel(style: .title1)
    private let subTitleLabel = DSLabel(style: .subheadline)

    public init(type: EmptyViewType, frame: CGRect = .zero) {
        self.type = type
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
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.itemSpacing
        self.stackView.alignment = .center
        
        let image = UIImage(
            systemName: self.type.imageName
        )?.withTintColor(
            .systemOrange,
            renderingMode: .alwaysOriginal
        )
        self.imageView.image = image
        self.titleLabel.text = self.type.title
        self.titleLabel.numberOfLines = 2
        self.subTitleLabel.text = self.type.subTitle
        self.subTitleLabel.numberOfLines = 0
    }
    
    private func makeConstraints() {
        self.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(
            equalTo: self.safeAreaLayoutGuide.centerYAnchor,
            constant: Metric.centerOffset
        ).isActive = true
        stackView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        stackView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
        
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(subTitleLabel)
        
        self.imageView.widthAnchor.constraint(equalToConstant: Metric.imageSize.width).isActive = true
        
        self.imageView.heightAnchor .constraint(equalToConstant: Metric.imageSize.height).isActive = true
    }
}

@available(iOS 17.0, *)
#Preview("Bookmark") {
    let view = EmptyView(type: .bookmark)
    return view
}

@available(iOS 17.0, *)
#Preview("search") {
    let view = EmptyView(type: .search)
    return view
}

@available(iOS 17.0, *)
#Preview("normal") {
    let view = EmptyView(type: .normal)
    return view
}
