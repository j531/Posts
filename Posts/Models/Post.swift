//
//  Post.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RealmSwift

class Post: Object, Decodable {

    // MARK: Public properties

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var user: User?
    @objc dynamic var userId: Int = 0
    let comments = List<Comment>()

    // MARK: Decodable

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case user
        case userId
    }

    // MARK: Object

    override static func primaryKey() -> String? {
        return #keyPath(id)
    }

}
