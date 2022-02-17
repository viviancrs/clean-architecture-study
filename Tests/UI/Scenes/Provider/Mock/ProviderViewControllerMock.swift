@testable import LocalSearch

class ProviderViewControllerMock: ProviderViewControllerType {
    var mockInvoke: Result<[Provider], DomainError>?
    @Spy var invokedShow: ProviderViewModel?

    func show(viewModel: ProviderViewModel) {
        invokedShow = viewModel
    }
}
