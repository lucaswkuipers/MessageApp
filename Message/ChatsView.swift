import UIKit

final class ChatsView: UIView {
    let viewModels: [ChatTableViewCellViewModel] = [
        ChatTableViewCellViewModel(
            title: "William Charles Schneider",
            lastMessage: "The Only Difference Between Me And A Homeless Man Is This Job. I Will Do Whatever It Takes To Survive Like I Did When I Was A Homeless Man",
            lastMessageDate: "16:20",
            image: UIImage(named: "creed")
        ),
        ChatTableViewCellViewModel(
            title: "Dwight Kurt Schrute III",
            lastMessage: "In the wild, there is no health care. In the wild, health care is, `Ow, I hurt my leg. I can't run. A lion eats me and I'm dead.` Well, I'm not dead. I'm the lion. You're dead.",
            lastMessageDate: "Yesterday",
            image: UIImage(named: "dwight")
        ),
        ChatTableViewCellViewModel(
            title: "Michael Gary Scott",
            lastMessage: "Do I need to be liked? Absolutely not. I like to be liked. I enjoy being liked. I have to be liked. But it’s not like this compulsive need like my need to be praised.",
            lastMessageDate: "Sunday",
            image: UIImage(named: "michael")
        ),
        ChatTableViewCellViewModel(
            title: "Kevin Malone",
            lastMessage: "Me think, why waste time say lot word, when few word do trick.",
            lastMessageDate: "13/04/22",
            image: UIImage(named: "kevin")
        ),
        ChatTableViewCellViewModel(
            title: "Jim",
            lastMessage: "Fact: Bears eat beets. Bears. Beets. Battlestar Galactica.",
            lastMessageDate: "13/04/22",
            image: UIImage(named: "jim")
        ),
        ChatTableViewCellViewModel(
            title: "Pam",
            lastMessage: "There’s A Lot Of Beauty In Ordinary Things. Isn’t That Kind Of The Point?",
            lastMessageDate: "13/04/22",
            image: UIImage(named: "pam")
        ),
        ChatTableViewCellViewModel(
            title: "Meredith",
            lastMessage: "Who's the one who didn't bring lice into the office? Meredith. Sure I gave everybody pink eye once, and my ex keyed a few of their cars, and yeah I BMed in the shredder on New Years. But I didn't bring the lice in. That was all Pam.",
            lastMessageDate: "13/04/22",
            image: UIImage(named: "meredith")
        ),
        ChatTableViewCellViewModel(
            title: "Andy",
            lastMessage: "I wish there was a way to know you were in the good old days before you actually left them.",
            lastMessageDate: "13/04/22",
            image: UIImage(named: "andy")
        ),

    ]

    let chatsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatTableViewCell.self)
        tableView.backgroundColor = .clear
        return tableView
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .systemPink

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

extension ChatsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell
        let viewModel = viewModels[indexPath.row]
        cell?.setupData(
            title: viewModel.title,
            lastMessage: viewModel.lastMessage,
            lastMessageDate: viewModel.lastMessageDate,
            image: viewModel.image
        )
        return  cell ?? ChatTableViewCell()
    }
}
