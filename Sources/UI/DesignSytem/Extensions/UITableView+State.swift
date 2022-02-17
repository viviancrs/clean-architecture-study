import UIKit

extension UITableView {
    func setErrorState() {
        let label = UILabel()
        label.text = AppStrings.errorLoadingData.localized
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.sizeToFit()

        backgroundView = label
        separatorStyle = .none
    }
}
