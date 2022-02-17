import Quick
import Nimble
@testable import LocalSearch

class ProviderLocalDataSourceTests: QuickSpec {
    override func spec() {
        var sut: ProviderLocalDataSource!

        describe("#fetch") {
            context("when the json is decoded correctly") {
                context("when there is not a query") {
                    beforeEach {
                        sut = ProviderLocalDataSource()
                    }

                    it("calls completion with success and expected data") {
                        let expectedProviders: [Provider] = JSONHelper().decode(from: "providers")!
                        let expectedResult: Result<[Provider], DataError> = .success(expectedProviders)

                        let returnedResult = invokeFetchAndGetResult(query: "")

                        expect(expectedResult).to(equal(returnedResult))
                    }
                }

                context("when there is a query") {
                    beforeEach {
                        let mockProviders = [Provider(name: "name"), Provider(name: "another name")]
                        let mockJSONHelper = JSONHelperMock(mockDecodable: mockProviders)
                        sut = ProviderLocalDataSource(jsonHelper: mockJSONHelper)
                    }

                    it("calls completion with success and expected data") {
                        let expectedProviders = [Provider(name: "name")]
                        let expectedResult: Result<[Provider], DataError> = .success(expectedProviders)

                        let returnedResult = invokeFetchAndGetResult(query: "name")

                        expect(expectedResult).to(equal(returnedResult))
                    }
                }
            }

            context("when an error occurs decoding the file") {
                beforeEach {
                    let mockJSONHelper = JSONHelperMock(mockDecodable: nil)
                    sut = ProviderLocalDataSource(jsonHelper: mockJSONHelper)
                }

                it("calls completion with failure and expected error") {
                    let expectedResult: Result<[Provider], DataError> = .failure(DataError.readingFile)

                    let returnedResult = invokeFetchAndGetResult(query: "")

                    expect(expectedResult).to(equal(returnedResult))
                }
            }
        }

        func invokeFetchAndGetResult(query: String = "") -> Result<[Provider], DataError>? {
            var result: Result<[Provider], DataError>?
            sut.fetch(query: query) {
                result = $0
            }
            return result
        }
    }
}
