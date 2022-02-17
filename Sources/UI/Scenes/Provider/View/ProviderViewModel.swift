struct ProviderViewModel: Equatable {
    enum State: Equatable {
        case ready(items: [ProviderCellViewModel], reloadStrategy: ReloadStrategy)
        case loading
        case error
    }

    private(set) var state: State = .loading

    func with(state: State) -> Self {
        var viewModel = self
        viewModel.state = state
        return viewModel
    }
}
