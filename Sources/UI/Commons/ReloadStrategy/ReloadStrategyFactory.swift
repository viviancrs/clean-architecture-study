import UIKit

protocol ReloadStrategyFactoryType {
    func create<T: Equatable>(newItems: [T],
                              oldItems: [T],
                              filtering: Bool) -> ReloadStrategy
}

struct ReloadStrategyFactory: ReloadStrategyFactoryType {
    func create<T: Equatable>(newItems: [T],
                              oldItems: [T],
                              filtering: Bool) -> ReloadStrategy {

        guard filtering else { return .all }

        let changes = calculateBatchChanges(newItems: newItems, oldItems: oldItems)
        return .batch(changes: changes)
    }

    private func calculateBatchChanges<T: Equatable>(newItems: [T], oldItems: [T]) -> ReloadStrategy.BatchChanges {
        let diff = newItems.difference(from: oldItems)

        let inserted = diff.insertions.compactMap { change -> IndexPath? in
            guard case let .insert(offset, _, _) = change else { return nil }

            return IndexPath(row: offset, section: 0)
        }

        let deleted = diff.removals.compactMap { change -> IndexPath? in
            guard case let .remove(offset, _, _) = change else { return nil }

            return IndexPath(row: offset, section: 0)
        }

        return .init(deleted: deleted, inserted: inserted)
    }
}
