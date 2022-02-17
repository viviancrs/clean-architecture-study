import UIKit

enum ReloadStrategy: Equatable {
    case all
    case batch(changes: BatchChanges)

    struct BatchChanges: Equatable {
        let deleted: [IndexPath]
        let inserted: [IndexPath]
    }
}
