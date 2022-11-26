//
//  UserCell.swift
//  Workshop
//
//  Created by Артем Шарапов on 26.11.2022.
//

import Foundation
import UIKit
import SnapKit


protocol Configurable {
    associatedtype Model
    
    func configure(_ model: Model)
}

class UserCell: UITableViewCell, Configurable {
    
    typealias Model = User
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .link
        return label
    }()
    
    private lazy var containerView: UIStackView = {
        let containerView = UIStackView(
            arrangedSubviews: [
                nameLabel,
                usernameLabel,
                emailLabel,
                phoneLabel,
                websiteLabel
            ]
        )
        containerView.axis = .vertical
        containerView.spacing = 5
        containerView.distribution = .equalCentering
        return containerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(_ model: Model) {
        nameLabel.text = model.name
        usernameLabel.text = model.username
        emailLabel.text = model.email
        phoneLabel.text = model.phone
        websiteLabel.text = model.website
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
