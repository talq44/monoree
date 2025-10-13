import UIKit

public class SpacerView: UIView {
    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
