import UIKit

final class MessageView: UIView {
    var hasSetupBefore = false
    var message: Message? {
        didSet {
            guard let message = message, !hasSetupBefore else { return }

            contentLabel.text = message.text
            containerView.backgroundColor = message.isSender ? .systemGreen : .systemBlue
            setupViewConstraints()
            hasSetupBefore = true
        }
    }

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        return view
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewStyle()
        setupViewHierarchy()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = .clear
    }

    private func setupViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(contentLabel)
    }

    private func setupViewConstraints() {
        guard let message = message else { return }

        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            contentLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            contentLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),

        ])

        if message.isSender {
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: 32),
                containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
                containerView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -32)
            ])
        }
    }
}
