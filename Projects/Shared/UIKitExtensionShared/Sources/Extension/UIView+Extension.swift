import UIKit

public extension UIView {
    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
}
