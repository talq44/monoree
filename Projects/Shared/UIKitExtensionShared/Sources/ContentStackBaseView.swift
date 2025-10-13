import UIKit

public class ContentStackBaseView: UIView {
    private let backgroundView = UIView()
    private let blurView: UIVisualEffectView
    private let tintOverlay = UIView()
    private let strokeView = UIView()
    private let _stackView: UIStackView
    
    private var contentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
    
    private var topC: NSLayoutConstraint!
    private var leadingC: NSLayoutConstraint!
    private var bottomC: NSLayoutConstraint!
    private var trailingC: NSLayoutConstraint!
    
    init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 8,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        self._stackView = UIStackView()
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        
        super.init(frame: .zero)
        isOpaque = false
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.cornerCurve = .continuous
        backgroundView.clipsToBounds = true
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        tintOverlay.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            tintOverlay.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.45)
        } else {
            tintOverlay.backgroundColor = UIColor(white: 1.0, alpha: 0.45)
        }
        
        strokeView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            strokeView.backgroundColor = UIColor.separator.withAlphaComponent(0.22)
        } else {
            strokeView.backgroundColor = UIColor(white: 0, alpha: 0.18)
        }
        
        _stackView.axis = axis
        _stackView.spacing = spacing
        _stackView.alignment = alignment
        _stackView.distribution = distribution
        _stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        backgroundView.addSubview(blurView)
        backgroundView.addSubview(tintOverlay)
        backgroundView.addSubview(_stackView)
        backgroundView.addSubview(strokeView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tintOverlay.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            tintOverlay.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            tintOverlay.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            tintOverlay.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
        
        topC = _stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: contentInsets.top)
        leadingC = _stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: contentInsets.leading)
        trailingC = backgroundView.trailingAnchor.constraint(equalTo: _stackView.trailingAnchor, constant: contentInsets.trailing)
        bottomC = backgroundView.bottomAnchor.constraint(equalTo: _stackView.bottomAnchor, constant: contentInsets.bottom)
        NSLayoutConstraint.activate([topC, leadingC, trailingC, bottomC])
        
        NSLayoutConstraint.activate([
            strokeView.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
            strokeView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            strokeView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            strokeView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])
        
        layer.masksToBounds = false
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateContentConstraints() {
        topC.constant = contentInsets.top
        leadingC.constant = contentInsets.leading
        trailingC.constant = contentInsets.trailing
        bottomC.constant = contentInsets.bottom
    }
    
    public var stackView: UIStackView { _stackView }
}

public final class ContentHStackView: ContentStackBaseView {
    public init(
        spacing: CGFloat = 8,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        super.init(axis: .horizontal, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class ContentVStackView: ContentStackBaseView {
    public init(
        spacing: CGFloat = 8,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill
    ) {
        super.init(axis: .vertical, spacing: spacing, alignment: alignment, distribution: distribution)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
