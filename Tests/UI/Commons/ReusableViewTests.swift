import Quick
import Nimble
@testable import LocalSearch

class ReusableViewTests: QuickSpec {

    override func spec() {
        describe("#reuseIdentifier") {
            it("returns class name") {
                let reuseIdentifier = UITableViewCell.reuseIdentifier
                expect(reuseIdentifier).to(equal("UITableViewCell"))
            }
        }
    }
}
