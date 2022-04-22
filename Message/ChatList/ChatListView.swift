import UIKit

protocol ChatListViewDelegate: AnyObject {
    func didSelectChat(_ chat: Chat)
}

final class ChatListView: UIView {
    weak var delegate: ChatListViewDelegate?

    let viewModels: [Chat] = [
        Chat(
            title: "William Charles Schneider",
            messages: [
                Message(
                    text: "The Only Difference Between Me And A Homeless Man Is This Job. I Will Do Whatever It Takes To Survive Like I Did When I Was A Homeless Man",
                    isSender: false)
            ],
            image: UIImage(named: "creed")
        ),
        Chat(
            title: "Dwight Kurt Schrute III",
            messages: [
                Message(
                    text: "In the wild, there is no health care. In the wild, health care is, `Ow, I hurt my leg. I can't run. A lion eats me and I'm dead.` Well, I'm not dead. I'm the lion. You're dead.",
                    isSender: false),
                Message(
                    text: "Cool one, Dwight..",
                    isSender: true),
            ],
            image: UIImage(named: "dwight")
        ),
        Chat(
            title: "Michael Gary Scott",
            messages: [
                Message(
                    text: "Do I need to be liked? Absolutely not. I like to be liked. I enjoy being liked. I have to be liked. But it’s not like this compulsive need like my need to be praised.",
                    isSender: false
                )
            ],
            image: UIImage(named: "michael")
        ),
        Chat(
            title: "Kevin Malone",
            messages: [
                Message(
                    text: "Me think, why waste time say lot word, when few word do trick.",
                    isSender: false),
            ],
            image: UIImage(named: "kevin")
        ),
        Chat(
            title: "Jimothy Halpert",
            messages: [
                Message(
                    text: "Fact: Bears eat beets. Bears. Beets",
                    isSender: false),
                Message(
                    text: "Great prank man...",
                    isSender: true),
            ],
            image: UIImage(named: "jim")
        )

    ]

    let chatsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatTableViewCell.self)
        tableView.backgroundColor = .clear
        return tableView
    }()

    init() {
        super.init(frame: .zero)

        setupViewStyle()
        setupViewHierarchy()
        setupViewConstraints()
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupViewStyle() {
        backgroundColor = .systemBackground
    }


    private func setupViewHierarchy() {
        addSubview(chatsTableView)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            chatsTableView.topAnchor.constraint(equalTo: topAnchor),
            chatsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chatsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            chatsTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension ChatListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cell: ChatTableViewCell(), at: indexPath)
        guard let viewModel = viewModels[safeIndex: indexPath.row] else { return cell }

        cell.setupData(
            title: viewModel.title,
            lastMessage: viewModel.messages.last?.text ?? "",
            lastMessageDate: "12/09/99",
            image: viewModel.image
        )

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = viewModels[indexPath.row]
        delegate?.didSelectChat(chat)
    }
}

extension ChatListView: GenericViewControllerDelegate {
    func viewWillAppear() {
        chatsTableView.deselectSelectedRow(animated: true)
    }
}
