import UIKit

final class ChatView: UIView {
    var currentIndex = 0
    let nextMessages: [Message] = [
        Message(
            text: "Lore ipsum Lore ipsum Lore ipsum Lore ipsum",
            isSender: false
        ),
        Message(
            text: "Lore ipsum Lore ipsum",
            isSender: true
        ),
        Message(
            text: "Lore ipsum Lore ipsum",
            isSender: false
        ),
        Message(
            text: "Lorem ipsum Lore ipsum Lore ipsum",
            isSender: true
        ),
        Message(
            text: "Lore ipsum Lore ipsum Lore ipsum Lore ipsum",
            isSender: true
        ),
        Message(
            text: "Lorem",
            isSender: false
        ),
        Message(
            text: "7 - true; Lorem ipsum",
            isSender: true
        ),
        Message(
            text: "8 - false",
            isSender: false
        ),
        Message(
            text: "9 - true; Lorem ipsum ipsum Lorem ipsum ipsum Lorem ipsum ipsum",
            isSender: true
        ),
        Message(
            text: "10 - false",
            isSender: false
        ),
        Message(
            text: "11 - true",
            isSender: true
        ),
        Message(
            text: "12 - false; Lorem ipsum ipsum Lorem ipsum ipsum Lorem ipsum ipsumLorem ipsum ipsum",
            isSender: false
        ),
        Message(
            text: "13 - false; Lorem ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "14 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "15 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "16 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "17 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        ),
        Message(
            text: "18 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        ),
        Message(
            text: "19 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "20 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        ),
        Message(
            text: "21 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "22 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        ),
        Message(
            text: "23 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "24 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "25 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "26 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "27 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "28 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "29 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        ),
        Message(
            text: "30 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "31 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "32 - true; Lore ipsum ipsum Lorem ",
            isSender: true
        )
    ]

    var messages: [Message] = [] {
        didSet {
            print("CUrrent index \(currentIndex)")
            print("Messages \(messages)")
            guard let newMessage = messages[safeIndex: currentIndex - 1] else { return }
            let newMessageView = MessageView()
            if currentIndex > 1 {
                let lastMessage = messages[currentIndex - 2]
                let lastMessageWasSender = lastMessage.isSender

                let currentMessageIsSender = newMessage.isSender

                if lastMessageWasSender != currentMessageIsSender {
                    let spacingView = UIView()
                    spacingView.translatesAutoresizingMaskIntoConstraints = false
                    spacingView.heightAnchor.constraint(equalToConstant: 15).isActive = true
                    messageStackView.addArrangedSubview(spacingView)
                } else {
                    let spacingView = UIView()
                    spacingView.translatesAutoresizingMaskIntoConstraints = false
                    spacingView.heightAnchor.constraint(equalToConstant: 5).isActive = true
                    messageStackView.addArrangedSubview(spacingView)
                }
            }
            newMessageView.message = newMessage
            newMessageView.translatesAutoresizingMaskIntoConstraints = false
//            newMessageView.backgroundColor = .red
            newMessageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
//            newMessageView.contentLabel.text = "Hellloooo"
            messageStackView.addArrangedSubview(newMessageView)
        }
    }

    let messageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    let messageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    init() {
        super.init(frame: .zero)
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()

        Timer.scheduledTimer(timeInterval: Double.random(in: 0.3...2), target: self, selector: #selector(addMessage), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(scrollToBottom), userInfo: nil, repeats: true)

    }

    @objc private func scrollToBottom() {
        DispatchQueue.main.async { [weak self] in
            self?.messageScrollView.scrollToBottom(animated: true)
        }
    }

    @objc private func addMessage() {
        print("Add message")

        guard let newMessage = nextMessages[safeIndex: currentIndex] else { return }
        currentIndex += 1

        messages.append(newMessage)

        Timer.scheduledTimer(timeInterval: Double.random(in: 0.8...2), target: self, selector: #selector(addMessage), userInfo: nil, repeats: false)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }

    private func setupViewHierarchy() {
        addSubview(messageScrollView)
        messageScrollView.addSubview(messageStackView)
    }

    private func setupViewConstraints() {
        messageScrollView.translatesAutoresizingMaskIntoConstraints = false
        messageStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageScrollView.topAnchor.constraint(equalTo: topAnchor),
            messageScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            messageScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageScrollView.rightAnchor.constraint(equalTo: rightAnchor),

            messageStackView.topAnchor.constraint(equalTo: messageScrollView.topAnchor),
            messageStackView.leftAnchor.constraint(equalTo: messageScrollView.leftAnchor),
            messageStackView.bottomAnchor.constraint(equalTo: messageScrollView.bottomAnchor),
            messageStackView.rightAnchor.constraint(equalTo: messageScrollView.rightAnchor)
        ])
    }
}
