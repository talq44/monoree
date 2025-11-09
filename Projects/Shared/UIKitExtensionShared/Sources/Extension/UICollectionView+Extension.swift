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
    
    // MARK: - Validation
    /// Returns true if the given indexPath points to an existing item in the collection view.
    /// Checks that the section and item are within bounds using `numberOfSections` and `numberOfItems(inSection:)`.
    func isValidItem(at indexPath: IndexPath) -> Bool {
        let sections = numberOfSections
        guard indexPath.section >= 0 && indexPath.section < sections else { return false }
        let items = numberOfItems(inSection: indexPath.section)
        return indexPath.item >= 0 && indexPath.item < items
    }
    
    /// Returns true if the given section index exists in the collection view.
    func isValidSection(_ section: Int) -> Bool {
        return section >= 0 && section < numberOfSections
    }
}

extension UICollectionReusableView: ReusableView {}
