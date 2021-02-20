//
//  MockPostStoreService.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
@testable import Posts

class MockPostStoreService: PostStoredDataProvider {
    var invokedGetPosts = false
    var invokedGetPostsCount = 0
    var stubbedGetPostsResult: [Post]! = []
    func getPosts() -> [Post] {
        invokedGetPosts = true
        invokedGetPostsCount += 1
        return stubbedGetPostsResult
    }
    var invokedWrite = false
    var invokedWriteCount = 0
    var shouldInvokeWriteWriteBlock = false
    func write(_ writeBlock: () -> Void) {
        invokedWrite = true
        invokedWriteCount += 1
        if shouldInvokeWriteWriteBlock {
            writeBlock()
        }
    }
    var invokedStoreObjects = false
    var invokedStoreObjectsCount = 0
    var invokedStoreObjectsParameters: (objects: [Object], Void)?
    var invokedStoreObjectsParametersList = [(objects: [Object], Void)]()
    func storeObjects(_ objects: [Object]) {
        invokedStoreObjects = true
        invokedStoreObjectsCount += 1
        invokedStoreObjectsParameters = (objects, ())
        invokedStoreObjectsParametersList.append((objects, ()))
    }
}
