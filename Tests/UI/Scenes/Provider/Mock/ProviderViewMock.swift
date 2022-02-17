import UIKit
@testable import LocalSearch

class ProviderViewMock: UIView, ProviderViewType {
    @Spy var invokedShow: ProviderViewModel?

    func show(viewModel: ProviderViewModel) {
        invokedShow = viewModel
    }
}
