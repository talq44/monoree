import UIKit

public extension UITableView {
    // MARK: - Cell Registration
    /// Register a UITableViewCell subclass using its class name as the reuse identifier.
    /// - Parameter cellType: The UITableViewCell subclass to register.
    func register<Cell: UITableViewCell>(_ cellType: Cell.Type) {
        self.register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
    }

    // MARK: - Cell Dequeue
    /// Dequeue a reusable cell of the expected type in a type-safe way.
    /// - Parameters:
    ///   - cellType: The expected UITableViewCell subclass.
    ///   - indexPath: The indexPath where the cell will be used.
    /// - Returns: A dequeued cell of the requested type.
    func dequeueReusableCell<Cell: UITableViewCell>(
        _ cellType: Cell.Type = Cell.self,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(identifier) as \(Cell.self)")
        }
        
        return cell
    }

    // MARK: - Header/Footer Registration
    /// Register a UITableViewHeaderFooterView subclass using its class name as the reuse identifier.
    /// - Parameter viewType: The UITableViewHeaderFooterView subclass to register.
    func registerHeaderFooter<View: UITableViewHeaderFooterView>(_ viewType: View.Type) {
        self.register(View.self, forHeaderFooterViewReuseIdentifier: String(describing: View.self))
    }

    // MARK: - Header/Footer Dequeue
    /// Dequeue a reusable header/footer view of the expected type in a type-safe way.
    /// - Parameter viewType: The expected UITableViewHeaderFooterView subclass.
    /// - Returns: A dequeued view of the requested type.
    func dequeueReusableHeaderFooter<View: UITableViewHeaderFooterView>(
        _ viewType: View.Type = View.self
    ) -> View {
        let identifier = String(describing: View.self)
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? View else {
            fatalError("Could not dequeue header/footer with identifier: \(identifier) as \(View.self)")
        }
        return view
    }
}
