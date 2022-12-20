//
//  LocalUsersViewController.swift
//  LabaKholosha

import UIKit

class LocalUsersViewController: UIViewController {

    let state = LocalUsersState()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        tableView.reloadData()
    }

    private func setupUI() {
        let nib = UINib(nibName: "UserCell", bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: "UserCell")

        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
    }
}

extension LocalUsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            fatalError("No correct cell")
        }

        cell.state = .init(user: state.users[indexPath.row])

        return cell
    }

}
