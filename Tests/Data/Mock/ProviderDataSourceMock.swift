@testable import LocalSearch

class ProviderDataSourceMock: ProviderDataSourceType {
    var mockGetAllResult: Result<[Provider], DataError>?
    @Spy var invokedFetch: String?

    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void) {
        invokedFetch = query
        if let result = mockGetAllResult {
            completion(result)
        }
    }
}
