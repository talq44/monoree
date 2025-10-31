import UIKit
import SnapKit
import UIKitExtensionShared

final class GameCategoryCell: UITableViewCell {
    private let itemView = GameCategoryComponentView(type: .image)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.l)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(type: GameType) {
        itemView.bind(type: type)
    }
}
