import Quick
import Nimble
@testable import LocalSearch

class ProviderViewControllerTests: QuickSpec {
    override func spec() {
        var sut: ProviderViewController!
        var mockPresenter: ProviderPresenterMock!
        var mockView: ProviderViewMock!

        beforeEach {
            mockPresenter = ProviderPresenterMock()
            mockView = ProviderViewMock()

            sut = ProviderViewController(presenter: mockPresenter, view: mockView)
        }

        describe("#initWithDecode") {
            it("throws fatal error") {
                expect { sut = ProviderViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("#viewDidLoad") {
            it("calls presenter's getAll") {
                _ = sut.view
                expect(mockPresenter.invokedGetAll).to(beTrue())
                expect(mockPresenter.$invokedGetAll.count).to(equal(1))
            }
        }

        describe("#show") {
            it("calls view show with expected model") {
                let viewModel = ProviderViewModel(state: .loading)
                sut.show(viewModel: viewModel)

                expect(mockView.invokedShow).toEventually(equal(viewModel))
                expect(mockView.$invokedShow.count).toEventually(equal(1))
            }
        }

        describe("#searchBar:textDidChange") {
            it("calls presenter's filter") {
                sut.searchBar(UISearchBar(), textDidChange: "text")

                expect(mockPresenter.invokedFilter).to(equal("text"))
                expect(mockPresenter.$invokedFilter.count).to(equal(1))
            }
        }
    }
}
