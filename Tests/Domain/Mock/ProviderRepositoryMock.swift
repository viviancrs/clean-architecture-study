@testable import LocalSearch

class ProviderRepositoryMock: ProviderRepositoryType {
    var mockFetchResult: Result<[Provider], DataError>?
    @Spy var invokedFetch: String?

    func fetch(query: String, completion: @escaping (Result<[Provider], DataError>) -> Void) {
        invokedFetch = query
        if let result = mockFetchResult {
            completion(result)
        }
    }
}
