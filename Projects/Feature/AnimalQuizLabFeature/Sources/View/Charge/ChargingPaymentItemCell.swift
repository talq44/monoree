import UIKit
import SnapKit
import UIKitExtensionShared

final class ChargingPaymentItemCell: UITableViewCell {
    struct State {
        let title: String
        let buttonTitle: String
        let action: (() -> Void)
    }
    
    private enum Metric {
        static let buttonHeight: CGFloat = 44
        static let buttonMinWidth: CGFloat = 100
    }
    
    private let stackView = HStackView(spacing: Spacing.s, alignment: .center)
    private let titleLabel = BaseLabel()
    private let button: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "뭐게요~~"
        
        let button = UIButton(configuration: config)
        
        return button
    }()
    
    private var didSelectButton: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(
            titleLabel,
            SpacerView(),
            button
        )
        
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(Spacing.l)
        }
        
        button.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(Metric.buttonMinWidth)
            make.height.equalTo(Metric.buttonHeight)
        }
        
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didSelectButton?()
        }), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(state: State) {
        titleLabel.text = state.title
        button.configuration?.title = state.buttonTitle
        didSelectButton = state.action
    }
}
