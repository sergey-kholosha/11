//
//  RemoteUsersViewController.swift
//  LabaKholosha

import UIKit

class RemoteUsersViewController: UITableViewController {

    private enum Segue: String {
        case showUser
    }

    var state = RemoteUsersState()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        tableView.reloadData()
        tableView.refreshControl?.beginRefreshing()
        refresh()
    }

    private func setupUI() {
        let nib = UINib(nibName: "UserCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "UserCell")

        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.refreshControl = refresh

        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
    }

    @IBAction func refresh() {
        Task { [weak self] in
            await self?.reloadUsers()
        }
    }

    private func reloadUsers() async {
        guard let url = URL(string: "http://8w8zz.mocklab.io/users") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let users = try JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.state = .init(users: users)
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        } catch let error {
            DispatchQueue.main.async { [weak self] in
                self?.showError(error: error)
            }
        }
    }

    private func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueValue = Segue(rawValue: identifier) else {
            return
        }
        switch segueValue {
        case .showUser:
            guard let destination = segue.destination as? UserDetailsViewController,
                    let selectedRow = tableView.indexPathForSelectedRow?.row else {
                return
            }
            let user = state.users[selectedRow]
            destination.state = .init(user: user)
        }
    }

}

extension RemoteUsersViewController {

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("No correct cell")
        }

        cell.state = .init(user: state.users[indexPath.row])

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else {
            return
        }
        state.users.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.showUser.rawValue, sender: self)
    }
}
