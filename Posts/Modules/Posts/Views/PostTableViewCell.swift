//
//  PostTableViewCell.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PostTableViewCell: UITableViewCell {

    // MARK: Private properties

    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = Fonts.optima.ofSize(17)
        $0.textColor = Colors.darkGray
    }

    private let authorLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = Colors.lightGray
    }

    // MARK: Initialisation

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    func setup(with item: PostRowItem) {
        titleLabel.text = item.title
        authorLabel.attributedText = AuthorAttributedTitleFactory.makeAttributedTitle(withAuthor: item.author)
    }

    private func setupView() {
        selectionStyle = .none
        buildView()
    }

    private func buildView() {
        let insets = UIEdgeInsets.uniform(20) + UIEdgeInsets.vertical(-3)

        addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: [.bottom], insets: insets)

        addSubview(authorLabel)
        authorLabel.edgesToSuperview(excluding: [.top], insets: insets)
        authorLabel.topToBottom(of: titleLabel, offset: 8)
    }
}
