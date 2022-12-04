//
//  PostsPresenter.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation

protocol IPostsPresenter: AnyObject {
    func getPost(at index: Int) -> Post
    func getNumberOfPosts() -> Int
}

final class PostsPresenter: IPostsPresenter {
    private let dataSource: IUserViewDataSource
    
    init(dataSource: IUserViewDataSource) {
        self.dataSource = dataSource
    }
    
    func getPost(at index: Int) -> Post {
        dataSource.getPost(at: index)
    }
    func getNumberOfPosts() -> Int {
        dataSource.getNumberOfPosts()
    }
}
