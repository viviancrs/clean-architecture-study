struct ProviderLocalDataSource: ProviderDataSourceType {
    let jsonHelper: JSONHelperType

    init(jsonHelper: JSONHelperType = JSONHelper()) {
        self.jsonHelper = jsonHelper
    }

    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void) {
        let decodedProviders: [Provider]? = jsonHelper.decode(from: "providers")

        guard let allProviders = decodedProviders else {
            completion(.failure(DataError.readingFile))
            return
        }

        let filteredProviders = filter(query: query, providers: allProviders)
        completion(.success(filteredProviders))
    }

    private func filter(query: String, providers: [Provider]) -> [Provider] {
        guard !query.isEmpty else { return providers }

        let filteredProviders = providers.filter { $0.name.starts(with: query) }
        return filteredProviders
    }
}
