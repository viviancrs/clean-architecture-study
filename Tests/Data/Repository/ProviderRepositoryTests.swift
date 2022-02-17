import Quick
import Nimble
@testable import LocalSearch

class ProviderRepositoryTests: QuickSpec {
    override func spec() {
        var sut: ProviderRepository!
        var mockDataSource: ProviderDataSourceMock!

        beforeEach {
            mockDataSource = ProviderDataSourceMock()
            sut = ProviderRepository(dataSource: mockDataSource)
        }

        describe("#getAll") {
            it("calls data source with correct query") {
                let query = "name"

                _ = makeRequestAndGetResult(query: query)

                expect(mockDataSource.$invokedFetch.count).to(equal(1))
                expect(mockDataSource.invokedFetch).to(equal(query))
            }

            context("when it is successful") {
                let providers = [ Provider(name: "name") ]

                beforeEach {
                    mockDataSource.mockGetAllResult = .success(providers)
                }

                it("calls completion with success") {
                    let expectedResult: Result<[Provider], DataError> = .success(providers)

                    let returnedResult = makeRequestAndGetResult()

                    expect(returnedResult).to(equal(expectedResult))
                }
            }

            context("when it fails") {
                beforeEach {
                    mockDataSource.mockGetAllResult = .failure(DataError.readingFile)
                }

                it("calls completion with failure") {
                    let expectedResult: Result<[Provider], DataError> = .failure(DataError.readingFile)

                    let returnedResult = makeRequestAndGetResult()

                    expect(returnedResult).to(equal(expectedResult))
                }
            }
        }

        func makeRequestAndGetResult(query: String = "") -> Result<[Provider], DataError>? {
            var result: Result<[Provider], DataError>?
            sut.fetch(query: query) {
                result = $0
            }
            return result
        }
    }
}
