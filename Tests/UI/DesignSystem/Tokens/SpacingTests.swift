import Quick
import Nimble
@testable import LocalSearch

class SpacingTests: QuickSpec {
    override func spec() {
        describe("#tiny") {
            it("returns expected value") {
                expect(Spacing.tiny).to(equal(8))
            }
        }

        describe("#standard") {
            it("returns expected value") {
                expect(Spacing.standard).to(equal(16))
            }
        }
    }
}
