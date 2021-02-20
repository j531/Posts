//
//  PostDetailCommentTableViewCell.swift
//  Posts
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PostDetailCommentTableViewCell: UITableViewCell {

    // MARK: Private properties

    private let authorLabel = UILabel().then {
        $0.font = Fonts.avenirNext.ofSize(13)
        $0.textColor = Colors.lightGray
    }

    private let commentLabel = UILabel().then {
        $0.font = Fonts.avenirNext.ofSize(13)
        $0.textColor = Colors.darkGray
        $0.numberOfLines = 0
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

    func setup(with item: PostDetailCommentItem) {
        authorLabel.text = item.author + ":"
        commentLabel.text = item.comment
    }

    private func setupView() {
        selectionStyle = .none
        buildView()
    }

    private func buildView() {
        let insets = UIEdgeInsets.uniform(30) + UIEdgeInsets.vertical(-14)

        addSubview(authorLabel)
        (authorLabel).edgesToSuperview(excluding: [.bottom], insets: insets)

        addSubview(commentLabel)
        commentLabel.edgesToSuperview(excluding: [.top], insets: insets)
        commentLabel.topToBottom(of: authorLabel, offset: 8)
    }
}
