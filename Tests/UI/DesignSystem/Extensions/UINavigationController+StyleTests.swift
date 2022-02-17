import Quick
import Nimble
@testable import LocalSearch

class UINavigationControllerStyleTests: QuickSpec {
    override func spec() {
        var sut: UINavigationController!

        beforeEach {
            sut = UINavigationController()
            sut.pushViewController(UIViewController(), animated: false)
            sut.pushViewController(UIViewController(), animated: false)
        }

        describe("#setTransparentStyle") {
            it("confifures transparent style") {
                sut.setTransparentStyle()

                expect(sut.navigationBar.isTranslucent).to(beTrue())
                expect(sut.navigationBar.tintColor).to(equal(.clear))
            }
        }
    }
}
