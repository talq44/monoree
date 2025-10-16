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
        let gameQuestion: GameQuestion
        let answers: [String]
        let didSelectAnswer: ((Int) -> Void)
    }
    
    private let stackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
    private let topView = UIView()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let questionLabel = BaseLabel(style: .extraLargeTitle, isMultipleLines: true)
    private let bottomStackView = VStackView(spacing: Spacing.m, distribution: .fillEqually)
    private var answerButtons: [UIButton] = []
    
    private var didSelectAnswer: ((Int) -> Void)?
    
    init(style: GameContentStyle) {
        super.init(frame: .zero)
        
        addSubview(stackView)
        
        stackView.addArrangedSubviews(
            topView.addSubviews(
                imageView,
                questionLabel
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func bind(state: State) {
        switch state.gameQuestion {
        case .image(let url):
            imageView.kf.setImage(
                with: URL(string: url),
                placeholder: UIImage(systemName: "photo"),
                options: [.transition(.fade(0.2))]
            )
            
        case .text(let text):
            questionLabel.text = text
        }
        
        didSelectAnswer = state.didSelectAnswer
        
        makeButtons(answers: state.answers)
    }
    
    private func makeButtons(answers: [String]) {
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
                let button = makeButton(title: answers[row], row: row)
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
                let button = makeButton(title: answers[row], row: row)
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array((answers.count / 2)..<answers.count).forEach { row in
                let button = makeButton(title: answers[row], row: row)
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
                let button = makeButton(title: answers[row], row: row)
                answerButtons.append(button)
                answerStackView.addArrangedSubview(button)
            }
            
            Array(3..<6).forEach { row in
                let button = makeButton(title: answers[row], row: row)
                answerButtons.append(button)
                answerStackView2.addArrangedSubview(button)
            }
            
            Array(6..<9).forEach { row in
                let button = makeButton(title: answers[row], row: row)
                answerButtons.append(button)
                answerStackView3.addArrangedSubview(button)
            }
        default:
            break
        }
    }
    
    private func makeButton(title: String, row: Int) -> UIButton {
        var configuration: UIButton.Configuration
        if #available(iOS 26.0, *) {
            configuration = UIButton.Configuration.glass()
        } else {
            configuration = UIButton.Configuration.borderedProminent()
        }
        
        var title = AttributedString(title)
        title.font = .preferredFont(forTextStyle: .extraLargeTitle2)
        configuration.attributedTitle = title
        
        let button = UIButton(configuration: configuration)
        button.addAction(
            UIAction(handler: { [weak self] _ in
                self?.didSelectAnswer?(row)
            }),
            for: .touchUpInside
        )
        
        return button
    }
}
