//
//  PostsViewController.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation
import UIKit
import SnapKit

protocol IPostsView: AnyObject {
    
}

final class PostsViewController: UIViewController {
    private let output: IPostsPresenter?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        return table
    }()
    
    init(output: IPostsPresenter?) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        if let postCell = (cell as? PostCell), let model = output?.getPost(at: indexPath.row) {
            postCell.configure(PostCellViewModel(title: model.title, text: model.body))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getNumberOfPosts() ?? .zero
    }
}
