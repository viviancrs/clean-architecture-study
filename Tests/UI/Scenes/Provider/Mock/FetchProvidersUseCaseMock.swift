@testable import LocalSearch

class FetchProvidersUseCaseMock: FetchProvidersUseCaseType {
    var mockInvoke: Result<[Provider], DomainError>?
    @Spy var invokedWithQuery: String?

    func invoke(query: String, completion: @escaping (Result<[Provider], DomainError>) -> Void) {
        invokedWithQuery = query
        if let result = mockInvoke {
            completion(result)
        }
    }
}
