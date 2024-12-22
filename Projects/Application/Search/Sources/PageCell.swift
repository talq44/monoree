//
//  PageCell.swift
//  Remember
//
//  Created by 박창규 on 12/3/24.
//

import UIKit

import SnapKit

final class PageCell: UICollectionViewCell {
    typealias State = UIView
    
    private let stackView = UIStackView()
    private var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfigure() {
        self.contentView.addSubview(stackView)
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    internal func bind(state: State) {
        guard self.view == nil else { return }
        self.view = state
        self.stackView.addArrangedSubview(state)
    }
}
