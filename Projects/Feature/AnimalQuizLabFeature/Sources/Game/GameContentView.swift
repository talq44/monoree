import UIKit
import SnapKit
import UIKitExtensionShared
import Kingfisher

enum GameContentStyle {
    case image
    case text
    case autoScroll
}

enum GameQuestion {
    case image(url: String)
    case text(String)
}

final class GameContentView: UIView {
    struct State {
        let type: GameType
        let gameQuestion: String
        let answers: [String]
        let didSelectAnswer: ((Int) -> Void)
    }
    
    private enum Metric {
        static let speakButtonSize: CGFloat = 48
        static let estimatedHeight: CGFloat = 30
    }
    
    private let stackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
    private let topView = UIView()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let questionLabel = BaseLabel(
        style: .extraLargeTitle,
        alignment: .center,
        isMultipleLines: true
    )
    private let speakButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "speaker.wave.3")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(
            pointSize: Metric.speakButtonSize,
            weight: .bold,
            scale: .large
        )
        
        let button = UIButton(configuration: config)
        button.isSymbolAnimationEnabled = true
        return button
    }()
    private let bottomStackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
    private var answerButtons: [UIButton] = []
    
    private var didSelectAnswer: ((Int) -> Void)?
    private var question: String?
    
    init(style: GameContentStyle) {
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        stackView.addArrangedSubviews(
            topView.addSubviews(
                imageView,
                questionLabel,
                speakButton
            ),
            bottomStackView
        )
        
        imageView.contentStyle()
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.s)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.s)
        }
        
        speakButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(Spacing.l)
        }
        
        speakButton.addAction(
            UIAction(handler: { [weak self] _ in
                guard let question = self?.question else { return }
                SpeakTTSManager.shared.stop()
                SpeakTTSManager.shared.speak(text: question)
            }),
            for: .touchUpInside
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func bind(state: State) {
        switch state.type {
        case .image, .categoryDifferent, .autoScroll:
            let imageURL = "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/\(state.gameQuestion).webp"
            imageView.kf.setImage(
                with: URL(string: imageURL),
                placeholder: UIImage(systemName: "photo"),
                options: [.transition(.fade(0.2))]
            )
            
            questionLabel.isHidden = true
            
        case .text:
            imageView.isHidden = true
            questionLabel.text = state.gameQuestion
        }
        
        speakButton.isHidden = !state.type.isShowSpeakButton
        
        if state.type.isShowSpeakButton {
            question = state.gameQuestion
        }
        
        didSelectAnswer = state.didSelectAnswer
        
        makeButtons(answers: state.answers, type: state.type)
    }
    
    private func makeButtons(answers: [String], type: GameType) {
        bottomStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        answerButtons.removeAll()
        
        switch answers.count {
        case ..<1:
            bottomStackView.isHidden = true
        case 1...3:
            let answerStackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
            
            bottomStackView.addArrangedSubviews(answerStackView)
            
            Array(0..<answers.count).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
        case 4...6:
            let answerStackView = HStackView(spacing: Spacing.m, distribution: .fillEqually)
            let answerStackView2 = HStackView(spacing: Spacing.m, distribution: .fillEqually)
            bottomStackView.addArrangedSubviews(
                answerStackView,
                answerStackView2
            )
            
            Array(0..<(answers.count / 2)).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array((answers.count / 2)..<answers.count).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView2.addArrangedSubview(button)
            }
        case 7...9:
            let answerStackView = HStackView(spacing: Spacing.m, distribution: .fillEqually)
            let answerStackView2 = HStackView(spacing: Spacing.m, distribution: .fillEqually)
            let answerStackView3 = HStackView(spacing: Spacing.m, distribution: .fillEqually)
            bottomStackView.addArrangedSubviews(
                answerStackView,
                answerStackView2,
                answerStackView3
            )
            
            Array(0..<3).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array(3..<6).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView2.addArrangedSubview(button)
            }
            
            Array(6..<9).forEach { row in
                let button = makeButton(title: answers[row], row: row, type: type, answersCount: answers.count)
                answerButtons.append(button)
                answerStackView3.addArrangedSubview(button)
            }
        default:
            break
        }
    }
    
    private func makeButton(title: String, row: Int, type: GameType, answersCount: Int) -> UIButton {
        var configuration: UIButton.Configuration
        if #available(iOS 26.0, *) {
            configuration = UIButton.Configuration.glass()
        } else {
            configuration = UIButton.Configuration.borderedProminent()
        }
        
        if type == .image {
            var title = AttributedString(title)
            title.font = .preferredFont(forTextStyle: .extraLargeTitle2)
            configuration.attributedTitle = title
        }
        
        let button = UIButton(configuration: configuration)
        button.addAction(
            UIAction(handler: { [weak self] _ in
                self?.didSelectAnswer?(row)
            }),
            for: .touchUpInside
        )
        
        if type == .text || type == .categoryDifferent {
            let imageURL = "https://cdn.jsdelivr.net/gh/talq44/monoree_images@main/animal/toy3D/" + title + ".webp"
            let url = URL(string: imageURL)
            button.imageView?.contentMode = .scaleAspectFit
            let itemHeight = (UIScreen.main.bounds.height / 2 / 2) - Metric.estimatedHeight
            let targetSize = CGSize(width: itemHeight, height: itemHeight)
            let processor = DownsamplingImageProcessor(size: targetSize)

            button.kf.setImage(
                with: url,
                for: .normal,
                placeholder: UIImage(systemName: "photo"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        }
        
        return button
    }
}
