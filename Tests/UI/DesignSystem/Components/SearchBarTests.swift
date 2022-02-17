import Quick
import Nimble
import SnapshotTesting
@testable import LocalSearch

class SearchBarTests: QuickSpec {
    override func spec() {
        var sut: SearchBar!

        beforeEach {
            sut = SearchBar()
            sut.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        }

        describe("#initWithDecode") {
            it("throws fatal error") {
                expect { sut = SearchBar(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("#init") {
            it("has a valid snapshot") {
                assertSnapshot(matching: sut, as: .image)
            }
        }
    }
}
