import UIKit
import SnapKit
import UIKitExtensionShared

final class GameCategoryCell: UITableViewCell {
    private let itemView = GameCategoryComponentView(type: .image)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(itemView)
        
        itemView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(Spacing.m)
            make.directionalHorizontalEdges.equalToSuperview().inset(Spacing.l)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(type: GameType) {
        itemView.bind(type: type)
    }
}
