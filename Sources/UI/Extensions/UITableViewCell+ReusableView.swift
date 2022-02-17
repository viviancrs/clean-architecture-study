import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                        cellType: T.Type = T.self) -> T {
        let reunseIdenfifier = cellType.reuseIdentifier
        let dequeueCell = self.dequeueReusableCell(withIdentifier: reunseIdenfifier, for: indexPath)
        guard let cell = dequeueCell as? T else {
            fatalError("Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }

}
