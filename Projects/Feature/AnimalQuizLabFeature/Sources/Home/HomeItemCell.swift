import UIKit
import SnapKit
import UIKitExtensionShared

final class HomeItemCell: UICollectionViewCell {
    private let stackView = HStackView(spacing: Spacing.s, alignment: .center)
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titlesStackView = VStackView(spacing: Spacing.xs)
    private let titleLabel = BaseLabel(style: .title2)
    private let subTitleLabel = BaseLabel(style: .callout)
    private let trailingChevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?
            .withTintColor(.darkGray))
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackView)
        contentView.addSubview(imageView)
        
        stackView.addArrangedSubviews(
            SpacerView(width: Spacing.l),
            titlesStackView.addArrangedSubviews(
                titleLabel,
                subTitleLabel
            ),
            SpacerView(),
            trailingChevronImageView,
            SpacerView(width: Spacing.l)
        )
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Spacing.l)
            make.directionalVerticalEdges.equalToSuperview().inset(Spacing.xs)
        }
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(state: HomeViewState.Item) {
        titleLabel.text = state.title
        subTitleLabel.text = state.subTitle
        subTitleLabel.isHidden = state.subTitle == nil || state.subTitle?.isEmpty == true
        
        bindBackgroundColor(hex: state.backgroundColor)
        bindBackgroundImage(imageURL: nil)
    }
    
    private func bindBackgroundColor(hex: String?) {
        guard let hex else { return }
        
        contentView.backgroundColor = UIColor(hex: hex, alpha: 0.6)
        contentView.layer.borderColor = UIColor(hex: hex)?.cgColor
    }
    
    private func bindBackgroundImage(imageURL: String?) {
        print(imageURL ?? "")
    }
}
