import UIKit

protocol Keyboardable: AnyObject {
    var notificationCenter: NotificationCenterType { get set }

    func addKeyboardObservers()
    func didUpdateKeyboard(height: CGFloat)
}

extension Keyboardable {
    func addKeyboardObservers() {
        _ = notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                           object: nil,
                                           queue: nil) { [weak self] notification in
            self?.keyboardWillShow(notification: notification)
        }

        _ = notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                           object: nil,
                                           queue: nil) { [weak self] _ in
            self?.keyboardWillHide()
        }
    }

    private func keyboardWillShow(notification: Notification) {
        guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        didUpdateKeyboard(height: keyboardFrame.height)
    }

    private func keyboardWillHide() {
        didUpdateKeyboard(height: 0)
    }
}
