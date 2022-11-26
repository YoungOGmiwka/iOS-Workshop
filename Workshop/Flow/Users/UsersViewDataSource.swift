//
//  UsersViewDataSource.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation

protocol IUserViewDataSource: AnyObject {
    func save(_ items: [User])
    func getUser(at index: Int) -> User
    
    var itemsCount: Int { get }
}

class UsersViewDataSource: IUserViewDataSource {
    private var items: [User] = []
    
    var itemsCount: Int {
        items.count
    }
    
    func getUser(at index: Int) -> User {
        items[index]
    }
    
    func save(_ items: [User]) {
        self.items = items
    }
}
