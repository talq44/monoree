import UIKit

public class HStackView: UIStackView {
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
