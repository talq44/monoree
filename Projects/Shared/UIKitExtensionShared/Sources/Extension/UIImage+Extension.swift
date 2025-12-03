import UIKit

public extension UIImage {
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
