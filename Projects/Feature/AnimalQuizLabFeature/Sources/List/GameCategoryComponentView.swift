import UIKit
import UIKitExtensionShared
import SnapKit

final class GameCategoryComponentView: BaseView {
    private let stackView = VStackView(spacing: Spacing.s)
    private let topInfoStackView = HStackView()
    private let textInfoStackView = VStackView()
    private let titleLabel = BaseLabel(style: .title1)
    private let descriptionLabel = BaseLabel(style: .title3, isMultipleLines: true)
    private let infoImageView = UIImageView()
    private let gameStackView = HStackView(spacing: Spacing.s, distribution: .fillEqually)
    
    init(type: GameType) {
        super.init()
        bind(type: type)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setup() {
        addSubviews(
            stackView.addSubviews(
                topInfoStackView.addArrangedSubviews(
                    infoImageView,
                    SpacerView(),
                    textInfoStackView.addArrangedSubviews(
                        titleLabel,
                        descriptionLabel
                    )
                ),
                gameStackView
            )
        )
        
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.m)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
    }
    
    func bind(type: GameType) {
        titleLabel.text = type.title
        descriptionLabel.text = type.description
    }
}
