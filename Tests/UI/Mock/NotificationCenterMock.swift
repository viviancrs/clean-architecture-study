import UIKit
@testable import LocalSearch

class NotificationCenterMock: NSObject, NotificationCenterType {

    @Spy var invokedAddObserver: (name: NSNotification.Name?, block: (Notification) -> Void)?
    private(set) var notifications: [NSNotification.Name: (Notification) -> Void] = [:]

    func addObserver(forName name: NSNotification.Name?,
                     object obj: Any?, queue: OperationQueue?,
                     using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        invokedAddObserver = (name: name, block: block)

        if let name = name {
            notifications[name] = block
        }
        return self
    }
}
