import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }

    func dequeue<Cell: UITableViewCell>(cellForItemAt indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(
            withIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell ?? Cell()
    }

    func deselectSelectedRow(animated: Bool)
    {
        guard let indexPathForSelectedRow = self.indexPathForSelectedRow else { return }
        deselectRow(at: indexPathForSelectedRow, animated: animated)
    }

}
