import UIKit

final class MessageCollectionViewCell: UICollectionViewCell {
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
        view.layer.cornerRadius = 10
        return view
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24)
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
        contentView.addSubview(containerView)
        containerView.addSubview(contentLabel)
    }

    private func setupViewConstraints() {
        guard let message = message else { return }

        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),

            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            contentLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            contentLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8),

        ])

        if message.isSender {
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 32),
                containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
                containerView.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -32)
            ])
        }
    }


}
