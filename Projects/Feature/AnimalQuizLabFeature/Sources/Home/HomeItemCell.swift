import UIKit
import SnapKit
import UIKitExtensionShared

final class HomeItemCell: UICollectionViewCell {
    private let stackView = HStackView(spacing: Spacing.s, alignment: .center)
    private let imageView = UIImageView()
    private let titlesStackView = VStackView(spacing: Spacing.xs)
    private let titleLabel = BaseLabel(style: .title3)
    private let subTitleLabel = BaseLabel(style: .body)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubviews(
            SpacerView(width: Spacing.l),
            titlesStackView.addArrangedSubviews(
                titleLabel,
                subTitleLabel
            ),
            SpacerView(),
            UIImageView(image: UIImage(systemName: "chevron.right")),
            SpacerView(width: Spacing.l)
        )
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(state: HomeViewState.Item) {
        titleLabel.text = state.title
        subTitleLabel.text = state.subTitle
//        contentView.backgroundColor = state.backgroundColor
    }
}
