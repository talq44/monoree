import UIKit

public extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ views: UIView...) -> Self {
        views.forEach({ self.addArrangedSubview($0) })
        return self
    }
}
