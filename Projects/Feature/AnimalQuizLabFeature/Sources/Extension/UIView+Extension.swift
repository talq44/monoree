import UIKit
import UIKitExtensionShared

extension UIView {
    func contentStyle() {
        layer.cornerRadius = Spacing.l
        layer.masksToBounds = true
        backgroundColor = .systemBackground
    }
}
