import UIKit
import UIKitExtensionShared
import SnapKit

final class GameCategoryComponentView: BaseView {
    var didSelectButton: ((GameType, GameType.QuizItem) -> Void)?
    
    private let stackView = VStackView(spacing: Spacing.s)
    private let topInfoStackView = HStackView(spacing: Spacing.s, alignment: .top)
    private let textInfoStackView = VStackView(spacing: Spacing.xs)
    private let titleLabel = BaseLabel(style: .title3)
    private let descriptionLabel = BaseLabel(style: .subheadline, isMultipleLines: true)
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
            stackView.addArrangedSubviews(
                topInfoStackView.addArrangedSubviews(
                    infoImageView,
                    textInfoStackView.addArrangedSubviews(
                        titleLabel,
                        descriptionLabel
                    )
                ),
                gameStackView
            )
        )
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.m)
        }
        
        infoImageView.snp.makeConstraints { make in
            make.size.equalTo(64)
        }
        
        infoImageView.contentMode = .scaleAspectFit
    }
    
    func bind(type: GameType) {
        infoImageView.image = UIImage(systemName: type.imageName)
        titleLabel.text = type.title
        descriptionLabel.text = type.description
        
        gameStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        answerButton(type: type).forEach { gameStackView.addArrangedSubviews($0) }
    }
    
    private func answerButton(type: GameType) -> [UIButton] {
        return type.quizItems.map { item in
            var config: UIButton.Configuration
            if #available(iOS 26.0, *) {
                config = UIButton.Configuration.glass()
            } else {
                config = UIButton.Configuration.borderedProminent()
            }
            
            config.image = UIImage(systemName: item.imageSystemName)
            config.imagePlacement = .top
            config.title = item.title
            config.contentInsets = NSDirectionalEdgeInsets(
                top: Spacing.l,
                leading: 0,
                bottom: Spacing.l,
                trailing: 0
            )
            
            return UIButton(
                configuration: config,
                primaryAction: UIAction(handler: { [weak self] _ in
                    self?.didSelectButton?(type, item)
                })
            )
        }
    }
}
