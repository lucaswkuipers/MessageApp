import UIKit

final class ChatView: UIView {
    let messagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    let messagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

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
    private func setupViewHierarchy() {
        addSubview(messagesStackView)
    }
    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            messagesStackView.topAnchor.constraint(equalTo: topAnchor),
            messagesStackView.leftAnchor.constraint(equalTo: leftAnchor),
            messagesStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messagesStackView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}
