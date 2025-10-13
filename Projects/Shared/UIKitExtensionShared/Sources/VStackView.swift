import UIKit

public class VStackView: UIStackView {
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
