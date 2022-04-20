import UIKit

final class ChatsView: UIView {
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
        backgroundColor = .blue
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
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell ?? ChatTableViewCell()
    }
}
