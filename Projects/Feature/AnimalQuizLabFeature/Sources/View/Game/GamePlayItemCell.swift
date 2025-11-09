//
//  GamePlayItemCell.swift
//  AnimalQuizLabFeature
//
//  Created by 박창규 on 11/9/25.
//

import UIKit
import SnapKit

final class GamePlayItemCell: UICollectionViewCell {
    private let itemView = GameContentView(style: .image)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(itemView)
        itemView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(state: GameContentView.State) {
        itemView.bind(state: state)
    }
}
