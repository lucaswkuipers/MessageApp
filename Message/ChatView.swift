import UIKit

final class ChatView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemPink
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {}
    private func setupViewHierarchy() {}
    private func setupViewConstraints() {}
}
