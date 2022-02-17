import Quick
import Nimble
@testable import LocalSearch

class ColorsTests: QuickSpec {
    override func spec() {
        let sut = Colors.self

        describe("#primary") {
            it("returns expected value") {
                expect(sut.primary).to(equal(UIColor(red: 254/255, green: 0, blue: 79/255, alpha: 1)))
            }
        }
    }
}
