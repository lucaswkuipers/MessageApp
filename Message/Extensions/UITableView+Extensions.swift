import UIKit

extension UITableView {
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }

    func dequeue<Cell>(cell: Cell, at indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        return dequeueReusableCell(
            withIdentifier: Cell.identifier,
            for: indexPath
        ) as? Cell ?? cell
    }

    func deselectSelectedRow(animated: Bool)
    {
        guard let indexPathForSelectedRow = self.indexPathForSelectedRow else { return }
        deselectRow(at: indexPathForSelectedRow, animated: animated)
    }

}
