import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

public extension UICollectionView {
    // MARK: - Register Cells
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    // MARK: - Register Supplementary Views
    func register<T: UICollectionReusableView>(
        _ viewType: T.Type,
        ofKind kind: String
    ) {
        self.register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewType.reuseIdentifier)
    }
    
    // MARK: - Dequeue Cells
    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        as type: T.Type = T.self
    ) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(type.reuseIdentifier)")
        }
        return cell
    }
    
    // MARK: - Dequeue Supplementary Views
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        for indexPath: IndexPath,
        as type: T.Type = T.self
    ) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(type.reuseIdentifier)")
        }
        return view
    }
}

extension UICollectionReusableView: ReusableView {}
