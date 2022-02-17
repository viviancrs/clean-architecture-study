import UIKit

class ProviderDataSource: NSObject, UITableViewDataSource {
    let items: [ProviderCellViewModel]

    init(items: [ProviderCellViewModel]) {
        self.items = items
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = items[indexPath.row]

        let cell: ProviderCell = tableView.dequeueReusableCell(for: indexPath)
        cell.show(viewModel: viewModel)
        return cell
    }
}
