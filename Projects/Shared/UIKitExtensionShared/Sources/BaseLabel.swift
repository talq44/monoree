import UIKit

public class BaseLabel: UILabel {
    public init(
        _ text: String? = nil,
        style: UIFont.TextStyle = .body,
        textColor: UIColor = .label,
        alignment: NSTextAlignment = .natural,
        isMultipleLines: Bool = false,
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        
        self.text = text
        self.font = .preferredFont(forTextStyle: style)
        self.textColor = textColor
        self.textAlignment = alignment
        self.numberOfLines = isMultipleLines ? 0 : 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
