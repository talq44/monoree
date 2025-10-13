import UIKit

// A base class to share the common liquid-glass background and stack setup
private class _ContentStackBaseView: UIView {
    let backgroundView = UIView()
    let blurView: UIVisualEffectView
    let tintOverlay = UIView()
    let strokeView = UIView()
    let stackView: UIStackView

    // Inset for content inside the rounded container
    var contentInsets: NSDirectionalEdgeInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12) {
        didSet { updateContentConstraints() }
    }

    // Constraints we adjust when insets change
    private var topC: NSLayoutConstraint!
    private var leadingC: NSLayoutConstraint!
    private var bottomC: NSLayoutConstraint!
    private var trailingC: NSLayoutConstraint!

    init(axis: NSLayoutConstraint.Axis,
         spacing: CGFloat = 8,
         alignment: UIStackView.Alignment = .fill,
         distribution: UIStackView.Distribution = .fill) {
        self.stackView = UIStackView()
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        super.init(frame: .zero)
        isOpaque = false

        // Background container with rounding
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 8
        backgroundView.layer.cornerCurve = .continuous
        backgroundView.clipsToBounds = true

        // Blur provides the liquid-glass feel
        blurView.translatesAutoresizingMaskIntoConstraints = false

        // A subtle overlay tint to resemble SwiftUI List grouped background
        tintOverlay.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            tintOverlay.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.45)
        } else {
            tintOverlay.backgroundColor = UIColor(white: 1.0, alpha: 0.45)
        }

        // A hairline stroke similar to list separators
        strokeView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            strokeView.backgroundColor = UIColor.separator.withAlphaComponent(0.22)
        } else {
            strokeView.backgroundColor = UIColor(white: 0, alpha: 0.18)
        }

        // Stack setup
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Build hierarchy
        addSubview(backgroundView)
        backgroundView.addSubview(blurView)
        backgroundView.addSubview(tintOverlay)
        backgroundView.addSubview(stackView)
        backgroundView.addSubview(strokeView)

        // Layout background to fill self
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Blur fills the background
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])

        // Tint overlay matches background
        NSLayoutConstraint.activate([
            tintOverlay.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            tintOverlay.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            tintOverlay.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            tintOverlay.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])

        // Content insets for stack
        topC = stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: contentInsets.top)
        leadingC = stackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: contentInsets.leading)
        trailingC = backgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: contentInsets.trailing)
        bottomC = backgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: contentInsets.bottom)
        NSLayoutConstraint.activate([topC, leadingC, trailingC, bottomC])

        // Stroke as a subtle outer border (inside the rounded container)
        NSLayoutConstraint.activate([
            strokeView.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
            strokeView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            strokeView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            strokeView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor)
        ])

        // Improve performance for translucency
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

    // MARK: - Public API forwarding

    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }

    func insertArrangedSubview(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }

    func setCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        stackView.setCustomSpacing(spacing, after: arrangedSubview)
    }
}

public final class ContentHStackView: _ContentStackBaseView {
    public init(spacing: CGFloat = 8,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill) {
        super.init(axis: .horizontal, spacing: spacing, alignment: alignment, distribution: distribution)
    }

    public var stackView: UIStackView { self.stackView }
}

public final class ContentVStackView: _ContentStackBaseView {
    public init(spacing: CGFloat = 8,
                alignment: UIStackView.Alignment = .fill,
                distribution: UIStackView.Distribution = .fill) {
        super.init(axis: .vertical, spacing: spacing, alignment: alignment, distribution: distribution)
    }

    public var stackView: UIStackView { self.stackView }
}
