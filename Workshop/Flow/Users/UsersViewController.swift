//
//  UsersViewController.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation
import UIKit
import SnapKit

private extension CGFloat {
    static let loaderDimention: CGFloat = 128
}

private extension String {
    static let cellReuseIdentifier = "UserCell"
    static let title = "Users"
}

protocol IUsersView: AnyObject {
    func showErrorAlert(_ message: String)
    func startLoader()
    func stopLoader()
}

class UsersViewController: UIViewController {
    
    private let alertFactory: IUsersAlertViewFactory
    
    private let output: IUsersPresenter?
    
    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.color = .blue
        return loader
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserCell.self, forCellReuseIdentifier: .cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(alertFactory: IUsersAlertViewFactory, output: IUsersPresenter) {
        self.alertFactory = alertFactory
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLoader()
        setupTableView()
        title = .title
        
        output?.viewDidLoad()
    }
    
    // MARK: - Private
    
    private func setupLoader() {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.size.equalTo(CGFloat.loaderDimention)
            make.center.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - IUsersView

extension UsersViewController: IUsersView {
    func showErrorAlert(_ message: String) {
        let alert = alertFactory.makeErrorAlert(with: message) { [weak self] in
            self?.dismiss(animated: true)
        }
        present(alert, animated: true)
    }
    
    func startLoader() {
        loader.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoader() {
        loader.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDelegate {
}

// MARK: - UITableViewDelegate

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseIdentifier, for: indexPath)
        if let item = output?.getItem(for: indexPath.row) {
            (cell as? UserCell)?.configure(item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.numberOfRows ?? .zero
    }
}
