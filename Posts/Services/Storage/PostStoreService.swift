//
//  PostStoreService.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol PostStoredDataProvider: ObjectStoredDataProvider {
    func getPosts() -> [Post]
}

class PostStoreService: PostStoredDataProvider {

    func getPosts() -> [Post] {
        let posts = Realm.default.objects(Post.self)
        return Array(posts)
    }
}
