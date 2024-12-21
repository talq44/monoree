//
//  DSLabel.swift
//  DesignSystem
//
//  Created by 박창규 on 11/29/24.
//

import UIKit

final public class DSLabel: UIView {
    
    private let label = UILabel()
    
    public var text: String? {
        didSet {
            self.label.text = text
        }
    }
    
    public var numberOfLines: Int = 1 {
        didSet {
            self.label.numberOfLines = numberOfLines
        }
    }
    
    public var textAlignment: NSTextAlignment = .left {
        didSet {
            self.label.textAlignment = textAlignment
        }
    }
    
    public init(style: UIFont.TextStyle, frame: CGRect = .zero) {
        super.init(frame: frame)
        label.font = .preferredFont(forTextStyle: style)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.makeConstratins()
    }
    
    private func makeConstratins() {
        self.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(
            equalTo: self.topAnchor
        ).isActive = true
        label.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        label.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
        label.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        ).isActive = true
    }
}
