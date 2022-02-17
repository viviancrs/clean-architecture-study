protocol ProviderRepositoryType {
    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void)
}

struct ProviderRepository: ProviderRepositoryType {
    private let dataSource: ProviderDataSourceType

    init(dataSource: ProviderDataSourceType = ProviderLocalDataSource()) {
        self.dataSource = dataSource
    }

    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void) {
        dataSource.fetch(query: query, completion: completion)
    }
}
