import UIKit
@testable import LocalSearch

class ReloadStrategyFactoryMock<Type: Equatable>: ReloadStrategyFactoryType {

    @Spy var invokedCreate: CreateType<Type>?
    var mockReloadStrategy: ReloadStrategy = .all

    func create<T: Equatable>(newItems: [T],
                              oldItems: [T],
                              filtering: Bool) -> ReloadStrategy {

        if let new = newItems as? [Type], let old = oldItems as? [Type] {
            invokedCreate = CreateType(newItems: new, oldItems: old, filtering: filtering)
        }

        return mockReloadStrategy
    }

    struct CreateType<T: Equatable> {
        let newItems: [T]
        let oldItems: [T]
        let filtering: Bool
    }
}
