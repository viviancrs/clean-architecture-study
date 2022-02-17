import Quick
import Nimble
@testable import LocalSearch

class ProviderTests: QuickSpec {

    override func spec() {
        var sut: Provider?

        describe("#decodable") {
            it("decodes json with expected value") {
                let bundle = Bundle.init(for: ProviderTests.self)
                sut = JSONHelper(bundle: bundle).decode(from: "provider")

                expect(sut?.name).to(equal("A+ Morumbi"))
            }
        }
    }
}
