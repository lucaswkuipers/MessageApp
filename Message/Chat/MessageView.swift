import UIKit

final class MessageView: UIView {
    var hasSetupBefore = false
    var message: Message? {
        didSet {
            guard let message = message, !hasSetupBefore else { return }

            contentLabel.text = message.text
            containerView.backgroundColor = message.isSender ? .systemGreen : .systemBlue

            setupViewHierarchy()
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

    let leftBubbleTailView: UIView = {
        let view = UIView()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 10))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 0))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemBlue.cgColor
        shapeLayer.lineWidth = 0

        view.layer.addSublayer(shapeLayer)
        return view
    }()

    let rightBubbleTailView: UIView = {
        let view = UIView()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.addLine(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemGreen.cgColor
        shapeLayer.lineWidth = 0

        view.layer.addSublayer(shapeLayer)
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewStyle()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = .clear
    }

    private func setupViewHierarchy() {
        guard let message = message else { return }

        addSubview(containerView)
        containerView.addSubview(contentLabel)

        if message.isSender {
            containerView.addSubview(rightBubbleTailView)
        } else {
            containerView.addSubview(leftBubbleTailView)
        }
    }

    private func setupViewConstraints() {
        guard let message = message else { return }

        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        rightBubbleTailView.translatesAutoresizingMaskIntoConstraints = false
        leftBubbleTailView.translatesAutoresizingMaskIntoConstraints = false

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
                containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),

                rightBubbleTailView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                rightBubbleTailView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
                containerView.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -32),

                leftBubbleTailView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
                leftBubbleTailView.rightAnchor.constraint(equalTo: containerView.leftAnchor)
            ])
        }
    }
}
