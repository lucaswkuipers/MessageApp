import UIKit

final class ChatView: UIView {
    var currentIndex = 0
    let nextMessages: [Message] = [
        Message(
            text: "1 - false",
            isSender: false
        ),
        Message(
            text: "2 - true; Some text goes here... let's see the dynamic size",
            isSender: true
        ),
        Message(
            text: "3 - false; Yes, text is interesting.",
            isSender: false
        ),
        Message(
            text: "4 - true; Yes, text is interesting. Yes, text is interesting.",
            isSender: true
        ),
        Message(
            text: "5 - true; Lorem ipsum ipsum",
            isSender: true
        ),
        Message(
            text: "6 - false",
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
            text: "17 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "18 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "19 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "20 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "21 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        ),
        Message(
            text: "22 - false; Lore ipsum ipsum Lorem ",
            isSender: false
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
            text: "29 - false; Lore ipsum ipsum Lorem ",
            isSender: false
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
            text: "32 - false; Lore ipsum ipsum Lorem ",
            isSender: false
        )
    ]
    var messages: [Message] = [] {
        didSet {
            let indexPath = IndexPath(row: messages.count - 1, section: 0)
            messageCollectionView.insertItems(at: [indexPath])
//            messageCollectionView.scrollToBottom(animated: true)
        }
    }

    let messageCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MessageCollectionViewCell.self, forCellWithReuseIdentifier: MessageCollectionViewCell.identifier)
        return collectionView
    }()

    init() {
        super.init(frame: .zero)
        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()

        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addMessage), userInfo: nil, repeats: true)
//        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    @objc private func addMessage() {
        print("Add message")

        guard let newMessage = nextMessages[safeIndex: currentIndex] else { return }
        currentIndex += 1

        messages.append(newMessage)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }

    private func setupViewHierarchy() {
        addSubview(messageCollectionView)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: topAnchor),
            messageCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension ChatView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let message = messages[safeIndex: indexPath.row] else { fatalError() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.identifier, for: indexPath) as? MessageCollectionViewCell
        cell?.message = message
        return cell ?? MessageCollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let message = messages[safeIndex: indexPath.row] else { return CGSize() }
        let font: UIFont = .systemFont(ofSize: 24)
        let width = UIScreen.main.bounds.width
        let height = message.text.height(withConstrainedWidth: width - 32 - 16, font: font)
        return CGSize(
            width: width,
            height: height + 16
        )
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
