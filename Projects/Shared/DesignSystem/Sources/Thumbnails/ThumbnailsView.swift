//
//  ThumbnailsView.swift
//  DesignSystem
//
//  Created by 박창규 on 11/29/24.
//

import UIKit

import Kingfisher

final public class ThumbnailsView: UIView {
    private enum Metric {
        static let round: CGFloat = 4
        static let emptyImageSize = CGSize(width: 32, height: 32)
    }
    
    private let emptyImageView = UIImageView()
    private let contentsImageView = UIImageView()
    
    public var imageContentMode: UIView.ContentMode = .scaleAspectFit {
        didSet {
            self.contentsImageView.contentMode = self.imageContentMode
        }
    }
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        self.addConfigure()
        self.makeConstraints()
    }
    
    private func addConfigure() {
        self.emptyImageView.backgroundColor = .lightGray
        self.contentsImageView.layer.cornerRadius = Metric.round
        self.contentsImageView.clipsToBounds = true
    }
    
    private func makeConstraints() {
        self.addSubview(emptyImageView)
        self.addSubview(contentsImageView)
        self.emptyImageView.image = UIImage(systemName: "photo")
        self.emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyImageView.centerYAnchor.constraint(
            equalTo: self.centerYAnchor
        ).isActive = true
        emptyImageView.centerXAnchor.constraint(
            equalTo: self.centerXAnchor
        ).isActive = true
        emptyImageView.widthAnchor.constraint(
            equalToConstant: Metric.emptyImageSize.width
        ).isActive = true
        emptyImageView.heightAnchor.constraint(
            equalToConstant: Metric.emptyImageSize.width
        ).isActive = true
        
        self.contentsImageView.translatesAutoresizingMaskIntoConstraints = false
        contentsImageView.topAnchor.constraint(
            equalTo: self.topAnchor
        ).isActive = true
        contentsImageView.bottomAnchor.constraint(
            equalTo: self.bottomAnchor
        ).isActive = true
        contentsImageView.leadingAnchor.constraint(
            equalTo: self.leadingAnchor
        ).isActive = true
        contentsImageView.trailingAnchor.constraint(
            equalTo: self.trailingAnchor
        ).isActive = true
    }
    
    public func setImage(_ url: String) {
        self.emptyImageView.isHidden = false
        self.contentsImageView.kf.setImage(
            with: URL(string: url)
        ) { [weak self] result in
            switch result {
            case .success:
                self?.emptyImageView.isHidden = true
            case .failure:
                self?.emptyImageView.isHidden = false
            }
        }
    }
    
    public func stopLoading() {
        self.contentsImageView.kf.cancelDownloadTask()
    }
}

@available(iOS 17.0, *)
#Preview("empty") {
    let view = ThumbnailsView()
    
    return view
}

@available(iOS 17.0, *)
#Preview("google") {
    let view = ThumbnailsView()
    view.setImage("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/480px-Google_%22G%22_logo.svg.png")
    
    return view
}

@available(iOS 17.0, *)
#Preview("cat") {
    let view = ThumbnailsView()
    view.setImage("https://loremflickr.com/600/400")
    return view
}
