import UIKit
import SnapKit
import UIKitExtensionShared

final class GameListItemCell: UITableViewCell {
    private let stackView = HStackView(spacing: Spacing.s, alignment: .center)
    private let leftImageView = UIImageView()
    private let titleLabel = BaseLabel(style: .title3)
    private let rightImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        contentView.addSubview(stackView)
        
        stackView.layer.cornerRadius = 8
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.separator.cgColor
        
        stackView.addArrangedSubviews(
            SpacerView(width: 0),
            leftImageView,
            titleLabel,
            SpacerView(),
            rightImageView,
            SpacerView(width: 0)
        )
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.xs)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 12, height: 20))
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

