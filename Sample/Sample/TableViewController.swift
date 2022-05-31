import UIKit
import SemiModalTransition

private let cellIdentifier = "Cell"

class TableViewController: UITableViewController {
    lazy var dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: tableView) { tableView, indexPath, itemIdentifier in
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = String(itemIdentifier)
        cell.contentConfiguration = config
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([1])
        snapshot.appendItems([1, 2, 3])
        dataSource.apply(snapshot)
    }
}
