//
//  UserDetailsViewController.swift
//  LabaKholosha
//
//  Created by Yevhen Herasymenko on 13.12.2022.
//

import UIKit

class UserDetailsViewController: UITableViewController {

    var state = UserDetailsState(user: nil)

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var yearsLabel: UILabel!
    @IBOutlet private weak var univercityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadUI()
    }

    private func reloadUI() {
        guard let user = state.user else {
            return
        }
        avatarImageView.image = user.image
            .flatMap { Data(base64Encoded: $0) }
            .flatMap { UIImage(data: $0) }
        nameLabel.text = user.name
        cityLabel.text = user.city
        univercityLabel.text = user.univercity
        yearsLabel.text = "\(user.years)"
        positionLabel.text = user.position
        tableView.beginUpdates()
        tableView.endUpdates()
    }

}
