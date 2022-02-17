import Quick
import Nimble
@testable import LocalSearch

class JSONHelperTests: QuickSpec {
    override func spec() {
        let bundle = Bundle(for: JSONHelperTests.self)

        describe("#decodeFromFile") {
            context("when the file is valid") {
                it("returns non nil object") {
                    let returnedObject: SampleObject? = JSONHelper(bundle: bundle).decode(from: "sample")

                    expect(returnedObject).toNot(beNil())
                }
            }

            context("when the file is invalid") {
                it("returns nil object") {
                    let returnedObject: SampleObject? = JSONHelper(bundle: bundle).decode(from: "anInvalidFile")

                    expect(returnedObject).to(beNil())
                }
            }
        }
    }

     struct SampleObject: Decodable {
         let name: String
     }
}
