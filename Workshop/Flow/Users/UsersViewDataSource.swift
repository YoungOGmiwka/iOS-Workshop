//
//  UsersViewDataSource.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation

protocol IUserViewDataSource: AnyObject {
    func saveUsers(_ items: [User])
    func savePosts(_ posts: [Post])
    func getUser(at index: Int) -> User
    func getUser(by id: Int) -> User?
    
    func getPost(at index: Int) -> Post
    func getNumberOfPosts() -> Int
    
    var itemsCount: Int { get }
}

class UsersViewDataSource: IUserViewDataSource {
    
    static let shared = UsersViewDataSource()
    
    private var items: [User]
    
    private var posts: [Post]
    
    private init(items: [User] = [], posts: [Post] = []) {
        self.items = items
        self.posts = posts
    }
    
    var itemsCount: Int {
        items.count
    }
    
    func getUser(at index: Int) -> User {
        items[index]
    }
    
    func getUser(by id: Int) -> User? {
        items.first { $0.id == id }
    }
    
    func saveUsers(_ items: [User]) {
        self.items = items
    }
    
    func savePosts(_ posts: [Post]) {
        self.posts = posts
    }
    
    func getPost(at index: Int) -> Post {
        posts[index]
    }
    func getNumberOfPosts() -> Int {
        posts.count
    }
}
