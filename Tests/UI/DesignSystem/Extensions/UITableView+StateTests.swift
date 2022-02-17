import Quick
import Nimble
import SnapshotTesting
@testable import LocalSearch

class UITableViewStateTests: QuickSpec {
    override func spec() {
        var sut: UITableView!

        beforeEach {
            sut = UITableView()
            sut.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        }

        describe("#setErrorState") {
            it("has a valid snapshot") {
                sut.setErrorState()

                assertSnapshot(matching: sut, as: .image)
            }
        }
    }
}
