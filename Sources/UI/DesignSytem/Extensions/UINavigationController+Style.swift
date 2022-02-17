import UIKit

extension UINavigationController {
    func setTransparentStyle() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.tintColor = .clear
    }
}
