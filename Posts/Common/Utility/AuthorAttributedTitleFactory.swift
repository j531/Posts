//
//  AuthorAttributedTitleFactory.swift
//  Posts
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation

struct AuthorAttributedTitleFactory {

    // MARK: Factory

    static func makeAttributedTitle(withAuthor author: String?) -> NSAttributedString {
        let author = author ?? "-"
        let authorText = NSLocalizedString("By", comment: "") + " \(author)"
        return NSAttributedString(string: authorText.uppercased(), attributes: [.kern: 0.8])
    }
}
