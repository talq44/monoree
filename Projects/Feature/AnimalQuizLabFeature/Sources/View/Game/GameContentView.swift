import UIKit
import SnapKit
import UIKitExtensionShared
import Kingfisher
//import AnimalListDomain

extension UIImage {
    /// Returns a new image resized to the given size.
    /// - Parameters:
    ///   - width: target width in points
    ///   - height: target height in points
    ///   - preserveAspectRatio: if true, fits within the box keeping aspect ratio (may add padding); if false, stretches to fill
    func withSize(width: CGFloat, height: CGFloat, preserveAspectRatio: Bool = true, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let target = CGSize(width: width, height: height)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: target, format: format)
        return renderer.image { _ in
            if preserveAspectRatio {
                let aspect = min(width / self.size.width, height / self.size.height)
                let newSize = CGSize(width: self.size.width * aspect, height: self.size.height * aspect)
                let origin = CGPoint(x: (width - newSize.width) / 2, y: (height - newSize.height) / 2)
                self.draw(in: CGRect(origin: origin, size: newSize))
            } else {
                self.draw(in: CGRect(origin: .zero, size: target))
            }
        }
    }
}

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
        let gameItem: GameItem
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
//    private let resourceBundle = AnimalListDomainResources.bundle
    
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
        switch state.gameItem.type {
        case .image, .categoryDifferent, .autoScroll:
            imageView.image = state.gameItem.question.image(type: "toy3d")
            
            questionLabel.isHidden = true
            
        case .text:
            imageView.isHidden = true
            questionLabel.text = state.gameItem.question.name
        }
        
        speakButton.isHidden = !state.gameItem.type.isShowSpeakButton
        
        if state.gameItem.type.isShowSpeakButton {
            question = state.gameItem.question.name
        }
        
        didSelectAnswer = state.didSelectAnswer
        
        makeButtons(choices: state.gameItem.choices, type: state.gameItem.type)
    }
    
    private func makeButtons(choices: [ProductItem], type: GameType) {
        bottomStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        answerButtons.removeAll()
        
        switch choices.count {
        case ..<1:
            bottomStackView.isHidden = true
        case 1...3:
            let answerStackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
            
            bottomStackView.addArrangedSubviews(answerStackView)
            
            Array(0..<choices.count).forEach { row in
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
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
            
            Array(0..<(choices.count / 2)).forEach { row in
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array((choices.count / 2)..<choices.count).forEach { row in
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
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
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array(3..<6).forEach { row in
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
                answerButtons.append(button)
                answerStackView2.addArrangedSubview(button)
            }
            
            Array(6..<9).forEach { row in
                let button = makeButton(
                    item: choices[row],
                    row: row,
                    type: type,
                    answersCount: choices.count
                )
                answerButtons.append(button)
                answerStackView3.addArrangedSubview(button)
            }
        default:
            break
        }
    }
    
    private func makeButton(item: ProductItem, row: Int, type: GameType, answersCount: Int) -> UIButton {
        var configuration: UIButton.Configuration
        if #available(iOS 26.0, *) {
            configuration = UIButton.Configuration.glass()
        } else {
            configuration = UIButton.Configuration.borderedProminent()
        }
        
        if type == .image {
            var title = AttributedString(item.name)
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
            let baseImage = item.image(type: "toy3d")
            let resized = baseImage?.withSize(width: 150, height: 150, preserveAspectRatio: true)
            button.setImage(resized?.withRenderingMode(.alwaysOriginal), for: .normal)
            
            button.configuration?.contentInsets = .zero
            button.configuration?.imagePadding = 0
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
        }
        
        return button
    }
}

