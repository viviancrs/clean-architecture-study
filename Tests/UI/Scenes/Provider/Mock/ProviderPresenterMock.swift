@testable import LocalSearch

class ProviderPresenterMock: ProviderPresenterType {
    var viewController: ProviderViewControllerType?
    @Spy var invokedGetAll: Bool?
    @Spy var invokedFilter: String?

    func getAll() {
        invokedGetAll = true
    }

    func filter(_ query: String) {
        invokedFilter = query
    }
}
