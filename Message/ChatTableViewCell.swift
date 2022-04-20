import UIKit

final class ChatTableViewCell: UITableViewCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.image = UIImage(named: "default_avatar")
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()

    let chatTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.text = "William Charles Schneider"
        label.numberOfLines = 1
        return label
    }()

    let lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        label.text = "The Only Difference Between Me And A Homeless Man Is This Job. I Will Do Whatever It Takes To Survive Like I Did When I Was A Homeless Man"
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        return label
    }()

    let lastMessageDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body, compatibleWith: nil)
        label.text = "13/04/22"
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

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }

    private func setupViewHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(chatTitleLabel)
        contentView.addSubview(lastMessageLabel)
        contentView.addSubview(lastMessageDateLabel)
    }

    private func setupViewConstraints() {
        contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            profileImageView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 16),
            profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),

            chatTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            chatTitleLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),

            lastMessageLabel.topAnchor.constraint(equalTo: chatTitleLabel.bottomAnchor),
            lastMessageLabel.leftAnchor.constraint(equalTo: chatTitleLabel.leftAnchor),
            lastMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            lastMessageLabel.rightAnchor.constraint(equalTo: chatTitleLabel.rightAnchor),

            lastMessageDateLabel.topAnchor.constraint(equalTo: chatTitleLabel.topAnchor),
            lastMessageDateLabel.leftAnchor.constraint(greaterThanOrEqualTo: chatTitleLabel.rightAnchor),
            lastMessageDateLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16),
        ])
    }
}
