import UIKit

class ProviderCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(viewModel: ProviderCellViewModel) {
        textLabel?.text = viewModel.title
    }
}
