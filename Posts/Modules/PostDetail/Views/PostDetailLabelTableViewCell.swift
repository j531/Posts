//
//  PostDetailLabelTableViewCell.swift
//  Posts
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints

class PostDetailLabelTableViewCell: UITableViewCell {

    // MARK: Public properties

    let bodyLabel = UILabel().then {
        $0.font = Fonts.avenirNext.ofSize(16)
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

    private func setupView() {
        selectionStyle = .none
        buildView()
    }

    private func buildView() {
        let insets = UIEdgeInsets.uniform(28) + UIEdgeInsets.vertical(-8)

        addSubview(bodyLabel)
        bodyLabel.edgesToSuperview(insets: insets)
    }
}
