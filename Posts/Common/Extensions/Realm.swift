//
//  Realm.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Helpers

extension Realm {

    static var `default`: Realm {
        do {
            return try Realm()
        } catch {
            print(error)
            fatalError("Can't get realm")
        }
    }

    static func removeDefault() {
        guard let realmURL = Realm.Configuration.defaultConfiguration.fileURL else { return }
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            try? FileManager.default.removeItem(at: URL)
        }
    }
}
