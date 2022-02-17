// swiftlint:disable function_body_length
import Quick
import Nimble
@testable import LocalSearch

class ProviderPresenterTests: QuickSpec {
    override func spec() {
        var sut: ProviderPresenter!
        var mockUseCaseFetch: FetchProvidersUseCaseMock!
        var mockViewController: ProviderViewControllerMock!
        var mockReloadStrategyFactory: ReloadStrategyFactoryMock<Provider>!

        beforeEach {
            mockUseCaseFetch = FetchProvidersUseCaseMock()
            mockViewController = ProviderViewControllerMock()
            mockReloadStrategyFactory = ReloadStrategyFactoryMock()

            sut = ProviderPresenter(useCaseFetch: mockUseCaseFetch,
                                    reloadStategyFactory: mockReloadStrategyFactory)
            sut.viewController = mockViewController
        }

        describe("#getAll") {
            it("calls fetch use case with empty query") {
                sut.getAll()

                expect(mockUseCaseFetch.invokedWithQuery).to(beEmpty())
                expect(mockUseCaseFetch.$invokedWithQuery.count).to(equal(1))
            }

            it("calls viewController's show with loading state") {
                let expectedViewModel = ProviderViewModel(state: .loading)

                sut.getAll()

                expect(mockViewController.invokedShow).to(equal(expectedViewModel))
                expect(mockViewController.$invokedShow.count).to(equal(1))
            }

            context("when it is successful") {
                let providers = [ Provider(name: "name") ]

                beforeEach {
                    mockReloadStrategyFactory.mockReloadStrategy = .all
                    mockUseCaseFetch.mockInvoke = .success(providers)
                }

                it("calls reloadStrategyFactory's create with expected parameters") {
                    sut.getAll()

                    expect(mockReloadStrategyFactory.invokedCreate?.newItems).to(equal(providers))
                    expect(mockReloadStrategyFactory.invokedCreate?.oldItems).to(beEmpty())
                    expect(mockReloadStrategyFactory.invokedCreate?.filtering).to(beFalse())
                    expect(mockReloadStrategyFactory.$invokedCreate.count).to(equal(1))
                }

                it("calls viewController's show with ready state") {
                    let items = [ProviderCellViewModel(title: "name")]
                    let expectedViewModel = ProviderViewModel(state: .ready(items: items, reloadStrategy: .all))

                    sut.getAll()

                    expect(mockViewController.invokedShow).to(equal(expectedViewModel))
                    expect(mockViewController.$invokedShow.count).to(equal(2))
                }
            }

            context("when it fails") {
                beforeEach {
                    mockUseCaseFetch.mockInvoke = .failure(DomainError.loadingData)
                }

                it("calls viewController's show with error state") {
                    let expectedViewModel = ProviderViewModel(state: .error)

                    sut.getAll()

                    expect(mockViewController.invokedShow).to(equal(expectedViewModel))
                    expect(mockViewController.$invokedShow.count).to(equal(2))
                }
            }
        }

        describe("#filter") {
            it("calls fetch use case with correct query") {
                let query = "name"

                sut.filter(query)

                expect(mockUseCaseFetch.invokedWithQuery).to(equal(query))
                expect(mockUseCaseFetch.$invokedWithQuery.count).to(equal(1))
            }

            context("when it is successful") {
                let firstProvidersResult = [ Provider(name: "name") ]
                let changes = ReloadStrategy.BatchChanges(deleted: [], inserted: [])

                beforeEach {
                    mockUseCaseFetch.mockInvoke = .success(firstProvidersResult)
                    mockReloadStrategyFactory.mockReloadStrategy = .batch(changes: changes)
                }

                it("calls reloadStrategyFactory's create with expected parameters") {
                    sut.filter("")

                    expect(mockReloadStrategyFactory.invokedCreate?.newItems).to(equal(firstProvidersResult))
                    expect(mockReloadStrategyFactory.invokedCreate?.oldItems).to(beEmpty())
                    expect(mockReloadStrategyFactory.invokedCreate?.filtering).to(beTrue())
                    expect(mockReloadStrategyFactory.$invokedCreate.count).to(equal(1))
                }

                it("calls viewController's show with ready state") {
                    let items = [ProviderCellViewModel(title: "name")]
                    let state = ProviderViewModel.State.ready(items: items, reloadStrategy: .batch(changes: changes))
                    let expectedViewModel = ProviderViewModel(state: state)

                    sut.filter("")

                    expect(mockViewController.invokedShow).to(equal(expectedViewModel))
                    expect(mockViewController.$invokedShow.count).to(equal(1))
                }

                context("when it is not the first time") {
                    beforeEach {
                        sut.filter("")
                    }

                    it("calls reloadStrategyFactory's create with old items") {
                        let newProviders = [ Provider(name: "name") ]
                        mockUseCaseFetch.mockInvoke = .success(newProviders)

                        sut.filter("")

                        expect(mockReloadStrategyFactory.invokedCreate?.newItems).to(equal(newProviders))
                        expect(mockReloadStrategyFactory.invokedCreate?.oldItems).to(equal(firstProvidersResult))
                        expect(mockReloadStrategyFactory.invokedCreate?.filtering).to(beTrue())
                        expect(mockReloadStrategyFactory.$invokedCreate.count).to(equal(2))
                    }
                }
            }

            context("when it fails") {
                beforeEach {
                    mockUseCaseFetch.mockInvoke = .failure(DomainError.loadingData)
                }

                it("calls viewController's show with error state") {
                    let expectedViewModel = ProviderViewModel(state: .error)

                    sut.filter("")

                    expect(mockViewController.invokedShow).to(equal(expectedViewModel))
                    expect(mockViewController.$invokedShow.count).to(equal(1))
                }
            }
        }
    }
}
