//
//  UserCell.swift
//  LabaKholosha
//
//  Created by Yevhen Herasymenko on 10.11.2022.
//

import UIKit

class UserCell: UITableViewCell {

    struct State {
        let user: User
    }

    var state: State? {
        didSet {
            renderState()
        }
    }

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func renderState() {
        guard let state = state else { return }

        avatarImageView.image = state.user.image?.data(using: .utf8).flatMap { UIImage(data: $0) }
        avatarImageView.isHidden = state.user.image == nil
        nameLabel.text = state.user.name
        infoLabel.text = [state.user.position, state.user.city, state.user.university]
            .joined(separator: " | ")
    }
}
