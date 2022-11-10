//
//  User.swift
//  LabaKholosha
//
//  Created by Yevhen Herasymenko on 10.11.2022.
//

import Foundation

struct User: Codable {
    let name: String
    let position: String
    let univercity: String
    let city: String
    let years: Int
    let image: String?
}
