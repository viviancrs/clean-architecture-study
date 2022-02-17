// swiftlint:disable function_body_length
import Quick
import Nimble
import SnapshotTesting
@testable import LocalSearch

class ProviderViewTests: QuickSpec {
    override func spec() {
        var sut: ProviderView!
        var mockNotificationCenter: NotificationCenterMock!

        beforeEach {
            mockNotificationCenter = NotificationCenterMock()

            sut = ProviderView(notificationCenter: mockNotificationCenter)
            sut.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        }

        describe("#initWithDecode") {
            it("throws fatal error") {
                expect { sut = ProviderView(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("#init") {
            it("conforms to Keyboardable") {
                expect(sut as Keyboardable).toNot(beNil())
            }

            it("calls notification center's addObserver") {
                let historyInvokedAddObserver = mockNotificationCenter.$invokedAddObserver.history
                expect(historyInvokedAddObserver[0]?.name).to(equal(UIResponder.keyboardWillShowNotification))
                expect(historyInvokedAddObserver[1]?.name).to(equal(UIResponder.keyboardWillHideNotification))
                expect(historyInvokedAddObserver.count).to(equal(2))
            }
        }

        describe("#show") {
            context("when has ready state with reload strategy as all") {
                beforeEach {
                    let viewModel = createViewModelWithReadyState(reloadStrategy: .all)
                    sut.show(viewModel: viewModel)
                }

                it("has a snapshot with ready state") {
                    assertSnapshot(matching: sut, as: .image, named: "ready_state_reload_all")
                }
            }

            context("when has ready state with reload strategy as batch") {
                beforeEach {
                    let viewModel = createViewModelWithReadyState(size: 10, reloadStrategy: .all)
                    sut.show(viewModel: viewModel)
                }

                context("when there is deletions") {
                    beforeEach {
                        let deleted = [IndexPath(row: 9, section: 0)]
                        let batchChanges = ReloadStrategy.BatchChanges(deleted: deleted, inserted: [])
                        let reloadStrategy = ReloadStrategy.batch(changes: batchChanges)
                        let viewModel = createViewModelWithReadyState(size: 9, reloadStrategy: reloadStrategy)
                        sut.show(viewModel: viewModel)
                    }

                    it("has a snapshot with updated data") {
                        assertSnapshot(matching: sut, as: .image, named: "ready_state_reload_batch_deletions")
                    }
                }

                context("when there is insertions") {
                    beforeEach {
                        let inserted = [IndexPath(row: 10, section: 0)]
                        let batchChanges = ReloadStrategy.BatchChanges(deleted: [], inserted: inserted)
                        let reloadStrategy = ReloadStrategy.batch(changes: batchChanges)
                        let viewModel = createViewModelWithReadyState(size: 11, reloadStrategy: reloadStrategy)
                        sut.show(viewModel: viewModel)
                    }

                    it("has a snapshot with updated data") {
                        assertSnapshot(matching: sut, as: .image, named: "ready_state_reload_batch_insertions")
                    }
                }
            }

            context("when has loading state") {
                beforeEach {
                    let viewModel = ProviderViewModel(state: .loading)
                    sut.show(viewModel: viewModel)
                }

                it("has a snapshot with loading state") {
                    assertSnapshot(matching: sut, as: .image, named: "loading_state")
                }
            }

            context("when has error state") {
                beforeEach {
                    let viewModel = ProviderViewModel(state: .error)
                    sut.show(viewModel: viewModel)
                }

                it("has a snapshot with error state") {
                    assertSnapshot(matching: sut, as: .image, named: "error_state")
                }
            }
        }

        describe("#didUpdateKeyboard") {
            beforeEach {
                let viewModel = createViewModelWithReadyState(reloadStrategy: .all)
                sut.show(viewModel: viewModel)
                sut.didUpdateKeyboard(height: 200)
            }

            it("has a snapshot with keyboard spacing") {
                assertSnapshot(matching: sut, as: .image, named: "keyboard_spacing")
            }
        }

        func createViewModelWithReadyState(size: Int = 10, reloadStrategy: ReloadStrategy) -> ProviderViewModel {
            var items = [ProviderCellViewModel]()
            for index in 0..<size {
                items.append(ProviderCellViewModel(title: "Cell \(index)"))
            }
            let viewModel = ProviderViewModel(state: .ready(items: items, reloadStrategy: reloadStrategy))
            return viewModel
        }
    }
}
