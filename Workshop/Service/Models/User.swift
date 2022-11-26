//
//  User.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation

struct User: Codable {
    let id: Int
    let name, username, email: String
    let phone, website: String
}
