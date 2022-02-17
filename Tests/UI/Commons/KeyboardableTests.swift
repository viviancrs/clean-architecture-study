import Quick
import Nimble
@testable import LocalSearch

class KeyboardableTests: QuickSpec {
    override func spec() {
        var sut: KeyboardableObject!
        var mockNotificationCenter: NotificationCenterMock!

        beforeEach {
            mockNotificationCenter = NotificationCenterMock()
            sut = KeyboardableObject(notificationCenter: mockNotificationCenter)
        }

        describe("#addKeyboardObservers") {
            beforeEach {
                sut.addKeyboardObservers()
            }

            it("calls notification center's addObserver") {
                let historyInvokedAddObserver = mockNotificationCenter.$invokedAddObserver.history
                expect(historyInvokedAddObserver[0]?.name).to(equal(UIResponder.keyboardWillShowNotification))
                expect(historyInvokedAddObserver[1]?.name).to(equal(UIResponder.keyboardWillHideNotification))
                expect(historyInvokedAddObserver.count).to(equal(2))
            }

            it("binds keyboard will show with didUpdateKeyboard") {
                let height: CGFloat = 100.0
                let userInfo = [UIResponder.keyboardFrameEndUserInfoKey: CGRect(x: 0, y: 0, width: 0, height: height)]
                let notification = Notification(name: UIResponder.keyboardWillShowNotification,
                                                object: nil,
                                                userInfo: userInfo)

                mockNotificationCenter.notifications[UIResponder.keyboardWillShowNotification]?(notification)

                expect(sut.invokedDidUpdateKeyboard).to(equal(height))
                expect(sut.$invokedDidUpdateKeyboard.count).to(equal(1))
            }

            it("binds keyboard will hide with didUpdateKeyboard") {
                let height: CGFloat = 0.0
                let notification = Notification(name: UIResponder.keyboardWillHideNotification)

                mockNotificationCenter.notifications[UIResponder.keyboardWillHideNotification]?(notification)

                expect(sut.invokedDidUpdateKeyboard).to(equal(height))
                expect(sut.$invokedDidUpdateKeyboard.count).to(equal(1))
            }
        }
    }

    class KeyboardableObject: Keyboardable {
        var notificationCenter: NotificationCenterType
        @Spy var invokedDidUpdateKeyboard: CGFloat?

        init(notificationCenter: NotificationCenterType) {
            self.notificationCenter = notificationCenter
        }

        func didUpdateKeyboard(height: CGFloat) {
            invokedDidUpdateKeyboard = height
        }
    }
}
