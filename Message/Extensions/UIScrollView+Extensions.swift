import UIKit

extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        let y = contentSize.height - 1
        let rect = CGRect(x: 0, y: y + safeAreaInsets.bottom, width: 1, height: 1)
        scrollRectToVisible(rect, animated: animated)
    }
}
