//
//  User.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, Decodable {

    // MARK: Public properties

    @objc dynamic var id: Int = 0
    @objc dynamic var username: String = ""

    // MARK: Object

    override static func primaryKey() -> String? {
        return #keyPath(id)
    }
}
