import Quick
import Nimble
@testable import LocalSearch

class DataFileTests: QuickSpec {
    override func spec() {
        var sut: Data?
        let bundle = Bundle(for: DataFileTests.self)

        describe("#initFromFile") {
            context("when the file is valid") {
                it("returns non nil data") {
                    sut = Data(contentsOf: "sample", bundle: bundle)

                    expect(sut).toNot(beNil())
                }
            }

            context("when the file is invalid") {
                it("returns nil data") {
                    sut = Data(contentsOf: "anInvalidFile", bundle: bundle)

                    expect(sut).to(beNil())
                }
            }
        }
    }
}
