import UIKit

struct ChatTableViewCellViewModel {
    let title: String
    let lastMessage: String
    let lastMessageDate: String
    let image: UIImage?
}

final class ChatTableViewCell: UITableViewCell {
    let chatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.image = UIImage(named: "default_avatar")
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let chatTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.text = "Chat title label"
        label.numberOfLines = 1
        return label
    }()

    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        label.text = "Last message label"
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        return label
    }()

    let lastMessageDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        label.text = "Last message date label"
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(
        title: String,
        lastMessage: String,
        lastMessageDate: String,
        image: UIImage?
    ) {
        chatTitleLabel.text = title
        lastMessageLabel.text = lastMessage
        lastMessageDateLabel.text = lastMessageDate
        chatImageView.image = image
    }

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }

    private func setupViewHierarchy() {
        contentView.addSubview(chatImageView)
        contentView.addSubview(chatTitleLabel)
        contentView.addSubview(lastMessageLabel)
        contentView.addSubview(lastMessageDateLabel)
    }

    private func setupViewConstraints() {
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            chatImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chatImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            chatImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
            chatImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            chatImageView.widthAnchor.constraint(equalToConstant: 60),
            chatImageView.heightAnchor.constraint(equalToConstant: 60),

            chatTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            chatTitleLabel.leftAnchor.constraint(equalTo: chatImageView.rightAnchor, constant: 16),

            lastMessageLabel.topAnchor.constraint(equalTo: chatTitleLabel.bottomAnchor),
            lastMessageLabel.leftAnchor.constraint(equalTo: chatTitleLabel.leftAnchor),
            lastMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            lastMessageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),

            lastMessageDateLabel.topAnchor.constraint(equalTo: chatTitleLabel.topAnchor),
            lastMessageDateLabel.leftAnchor.constraint(greaterThanOrEqualTo: chatTitleLabel.rightAnchor),
            lastMessageDateLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),
        ])
    }
}
