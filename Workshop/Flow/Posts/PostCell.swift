//
//  PostCell.swift
//  Workshop
//
//  Created by Артем Шарапов on 04.12.2022.
//

import Foundation
import UIKit
import SnapKit

struct PostCellViewModel {
    let title: String
    let text: String
}

final class PostCell: UITableViewCell, Configurable {
    
    typealias Model = PostCellViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16, weight: .light)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(5)
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(5)
            make.height.greaterThanOrEqualTo(200)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostCell {
    func configure(_ model: PostCellViewModel) {
        titleLabel.text = model.title
        textView.text = model.text
    }
}
