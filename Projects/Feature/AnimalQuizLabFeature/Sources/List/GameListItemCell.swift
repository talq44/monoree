import UIKit
import SnapKit
import UIKitExtensionShared

final class GameListItemCell: UITableViewCell {
    private let backgroundImageView = UIImageView()
    private let stackView = HStackView(spacing: Spacing.s, alignment: .center)
    private let leftImageView = UIImageView()
    private let titleLabel = BaseLabel(style: .title2)
    private let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        contentView.addSubview(backgroundImageView)
        
        stackView.addArrangedSubviews(
            leftImageView,
            titleLabel,
            SpacerView(),
            rightImageView
        )
        
        leftImageView.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func bind(state: GameListType) {
        titleLabel.text = state.description
        leftImageView.image = state.leftImage
    }
}
