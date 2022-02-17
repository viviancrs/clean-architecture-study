import Quick
import Nimble
@testable import LocalSearch

class FetchProvidersUseCaseTests: QuickSpec {
    override func spec() {
        var sut: FetchProvidersUseCase!
        var mockRepository: ProviderRepositoryMock!

        beforeEach {
            mockRepository = ProviderRepositoryMock()
            sut = FetchProvidersUseCase(repository: mockRepository)
        }

        describe("#invoke") {
            it("calls repository with correct query") {
                let query = "name"

                _ = invokeMethodAndGetResult(query: query)

                expect(mockRepository.invokedFetch).to(equal(query))
                expect(mockRepository.$invokedFetch.count).to(equal(1))
            }

            context("when it is successful") {
                let providers = [ Provider(name: "name") ]

                beforeEach {
                    mockRepository.mockFetchResult = .success(providers)
                }

                it("calls completion with success") {
                    let expectedResult: Result<[Provider], DomainError> = .success(providers)

                    let returnedResult = invokeMethodAndGetResult()

                    expect(returnedResult).to(equal(expectedResult))
                }
            }

            context("when it fails with readingFile") {
                beforeEach {
                    mockRepository.mockFetchResult = .failure(DataError.readingFile)
                }

                it("calls completion with loadingData failure") {
                    let expectedResult: Result<[Provider], DomainError> = .failure(DomainError.loadingData)

                    let returnedResult = invokeMethodAndGetResult()

                    expect(returnedResult).to(equal(expectedResult))
                }
            }
        }

        func invokeMethodAndGetResult(query: String = "") -> Result<[Provider], DomainError>? {
            var result: Result<[Provider], DomainError>?
            sut.invoke(query: query) {
                result = $0
            }
            return result
        }
    }
}
