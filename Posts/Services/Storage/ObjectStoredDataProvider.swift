//
//  ObjectStoredDataProvider.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RealmSwift

protocol ObjectStoredDataProvider {
    func write(_ writeBlock: () -> Void)
    func storeObjects(_ objects: [Object])
}

extension ObjectStoredDataProvider {

    // MARK: Data
    // Note: all Realm throwable methods will soft fail (try?) - handle?

    func write(_ writeBlock: () -> Void) {
        try? Realm.default.write {
            writeBlock()
        }
    }

    func storeObjects(_ objects: [Object]) {
        write { Realm.default.add(objects, update: .modified) }
    }
}
