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

private extension CGFloat {
    static let usernameFontSize: CGFloat = 32
    static let defaultFontSize: CGFloat = 16
    static let inset: CGFloat = 10
    static let spacing: CGFloat = 5
}

class UserCell: UITableViewCell, Configurable {
    
    typealias Model = User
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .usernameFontSize)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: .defaultFontSize)
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize)
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: .defaultFontSize)
        return label
    }()
    
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: .defaultFontSize)
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
        containerView.spacing = .spacing
        containerView.distribution = .equalCentering
        return containerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.inset)
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
