// swiftlint:disable function_body_length
import Quick
import Nimble
@testable import LocalSearch

class ReloadStrategyFactoryTests: QuickSpec {
    override func spec() {
        var sut: ReloadStrategyFactory!

        beforeEach {
            sut = ReloadStrategyFactory()
        }

        describe("#create") {
            context("when is not filtering") {
                it("creates reload strategy as all") {
                    let returned = sut.create(newItems: [Item](),
                                              oldItems: [Item](),
                                              filtering: false)

                    expect(returned).to(equal(.all))
                }
            }

            context("when is filtering") {
                context("when the new and old items are the same") {
                    it("creates reload strategy as batch witch expected changes") {
                        let expectedChanges = ReloadStrategy.BatchChanges(deleted: [],
                                                                          inserted: [])

                        let returned = sut.create(newItems: [Item](),
                                                  oldItems: [Item](),
                                                  filtering: true)

                        expect(returned).to(equal(.batch(changes: expectedChanges)))
                    }
                }

                context("when there is insertions") {
                    it("creates reload strategy as batch with inserted items in changes") {
                        let expectedChanges = ReloadStrategy.BatchChanges(deleted: [],
                                                                          inserted: [IndexPath(row: 0, section: 0)])

                        let returned = sut.create(newItems: [Item(name: "")],
                                                  oldItems: [Item](),
                                                  filtering: true)

                        expect(returned).to(equal(.batch(changes: expectedChanges)))
                    }
                }

                context("when there is deletions") {
                    it("creates reload strategy as batch with deleted items in changes") {
                        let expectedChanges = ReloadStrategy.BatchChanges(deleted: [IndexPath(row: 0, section: 0)],
                                                                          inserted: [])

                        let returned = sut.create(newItems: [],
                                                  oldItems: [Item(name: "")],
                                                  filtering: true)

                        expect(returned).to(equal(.batch(changes: expectedChanges)))
                    }
                }

                context("when there is deletions and insertions") {
                    it("creates reload strategy as batch with changes") {
                        let expectedChanges = ReloadStrategy.BatchChanges(deleted: [IndexPath(row: 0, section: 0)],
                                                                          inserted: [IndexPath(row: 0, section: 0)])

                        let returned = sut.create(newItems: [Item(name: "new name")],
                                                  oldItems: [Item(name: "old name")],
                                                  filtering: true)

                        expect(returned).to(equal(.batch(changes: expectedChanges)))
                    }
                }
            }
        }
    }

    struct Item: Equatable {
        let name: String
    }
}
