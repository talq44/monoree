import UIKit
import UIKitExtensionShared

extension UIView {
    func contentStyle() {
        layer.cornerRadius = Spacing.m
        layer.masksToBounds = true
        backgroundColor = .systemBackground
    }
}
