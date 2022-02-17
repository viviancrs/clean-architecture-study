protocol ProviderDataSourceType {
    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void)
}
