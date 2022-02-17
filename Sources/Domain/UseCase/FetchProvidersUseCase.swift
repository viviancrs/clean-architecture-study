import Foundation

protocol FetchProvidersUseCaseType {
    func invoke(query: String, completion: @escaping (Result<[Provider], DomainError>) -> Void)
}

class FetchProvidersUseCase: FetchProvidersUseCaseType {
    private let repository: ProviderRepositoryType

    init(repository: ProviderRepositoryType = ProviderRepository()) {
        self.repository = repository
    }

    func invoke(query: String, completion: @escaping (Result<[Provider], DomainError>) -> Void) {
        repository.fetch(query: query) { [weak self] result in
            switch result {
            case .success(let providers):
                completion(.success(providers))
            case .failure(let error):
                self?.handle(error: error, completion: completion)
            }
        }
    }

    private func handle(error: DataError, completion: @escaping (Result<[Provider], DomainError>) -> Void) {
        switch error {
        case .readingFile:
            completion(.failure(.loadingData))
        }
    }
}
