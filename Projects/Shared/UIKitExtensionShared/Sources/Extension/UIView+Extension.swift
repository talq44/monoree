import UIKit

public extension UIView {
    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach { addSubview($0) }
        return self
    }
}
