//
//  Post.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
