//
//  PostDetailTitleTableViewCell.swift
//  Posts
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit

class PostDetailTitleTableViewCell: UITableViewCell {

    // MARK: Private properties

    private let titleLabel = UILabel().then {
        $0.font = Fonts.optima.ofSize(30)
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private let authorLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = Colors.lightGray
        $0.textAlignment = .center
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

    func setup(with item: PostDetailTitleRowItem) {
        titleLabel.text = item.title.capitalized
        authorLabel.attributedText = AuthorAttributedTitleFactory.makeAttributedTitle(withAuthor: item.author)
    }

    private func setupView() {
        selectionStyle = .none
        buildView()
    }

    private func buildView() {
        let insets = UIEdgeInsets.uniform(30)

        addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: [.bottom], insets: insets)

        addSubview(authorLabel)
        authorLabel.edgesToSuperview(excluding: [.top], insets: insets)
        authorLabel.topToBottom(of: titleLabel, offset: 18)
    }
}
