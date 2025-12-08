import UIKit

public extension UIImage {
    /// Returns a new image resized to the given size.
    /// - Parameters:
    ///   - width: target width in points
    ///   - height: target height in points
    ///   - preserveAspectRatio: if true, fits within the box keeping aspect ratio (may add padding); if false, stretches to fill
    func withSize(
        width: CGFloat,
        height: CGFloat,
        preserveAspectRatio: Bool = true,
        scale: CGFloat = UIScreen.main.scale
    ) -> UIImage {
        let target = CGSize(width: width, height: height)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: target, format: format)
        return renderer.image { [weak self] _ in
            let currentWidth: CGFloat = self?.size.width ?? 0
            let currentHeight: CGFloat = self?.size.height ?? 0
            // 0 크기 이미지를 방어하여 비율 계산 시 분모 0을 피합니다.
            guard currentWidth > 0, currentHeight > 0 else {
                self?.draw(in: CGRect(origin: .zero, size: target))
                return
            }
            
            if preserveAspectRatio {
                let aspect = min(width / currentWidth, height / currentHeight)
                if preserveAspectRatio {
                    let aspect = min(width / currentWidth, height / currentHeight)
                    let newSize = CGSize(width: currentWidth * aspect, height: currentHeight * aspect)
                    let origin = CGPoint(x: (width - newSize.width) / 2, y: (height - newSize.height) / 2)
                    self?.draw(in: CGRect(origin: origin, size: newSize))
                } else {
                    self?.draw(in: CGRect(origin: .zero, size: target))
                }
            }
        }
    }
}
