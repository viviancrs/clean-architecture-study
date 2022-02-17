protocol ProviderPresenterType {
    var viewController: ProviderViewControllerType? { get set }
    func getAll()
    func filter(_ query: String)
}

class ProviderPresenter: ProviderPresenterType {
    weak var viewController: ProviderViewControllerType?
    private let useCaseFetch: FetchProvidersUseCaseType
    private let reloadStategyFactory: ReloadStrategyFactoryType
    private var providers: [Provider] = []

    private var viewModel: ProviderViewModel = ProviderViewModel() {
        didSet {
            viewController?.show(viewModel: viewModel)
        }
    }

    init(useCaseFetch: FetchProvidersUseCaseType = FetchProvidersUseCase(),
         reloadStategyFactory: ReloadStrategyFactoryType = ReloadStrategyFactory()) {
        self.useCaseFetch = useCaseFetch
        self.reloadStategyFactory = reloadStategyFactory
    }

    func getAll() {
        viewModel = viewModel.with(state: .loading)
        fetch(filtering: false)
    }

    func filter(_ query: String) {
        fetch(query: query, filtering: true)
    }
}

extension ProviderPresenter {
    private func handle(result: Result<[Provider], DomainError>, filtering: Bool) {
        switch result {
        case .success(let newProviders):
            let items = createCellsViewModel(from: newProviders)
            let reloadStrategy = reloadStategyFactory.create(newItems: newProviders,
                                                             oldItems: self.providers,
                                                             filtering: filtering)
            viewModel = viewModel.with(state: .ready(items: items, reloadStrategy: reloadStrategy))

            self.providers = newProviders
        case .failure:
            viewModel = viewModel.with(state: .error)
        }
    }

    private func createCellsViewModel(from providers: [Provider]) -> [ProviderCellViewModel] {
        providers.map { provider in
            return ProviderCellViewModel(title: provider.name)
        }
    }

    private func fetch(query: String = "", filtering: Bool) {
        useCaseFetch.invoke(query: query) { [weak self] result in
            self?.handle(result: result, filtering: filtering)
        }
    }
}
