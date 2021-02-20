//
//  MockPostModelController.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
@testable import Posts

class MockPostModelController: PostDomain {
    var invokedGetRemotePosts = false
    var invokedGetRemotePostsCount = 0
    var stubbedGetRemotePostsResult: Observable<[Post]>!
    func getRemotePosts() -> Observable<[Post]> {
        invokedGetRemotePosts = true
        invokedGetRemotePostsCount += 1
        return stubbedGetRemotePostsResult
    }
    var invokedGetLocalPosts = false
    var invokedGetLocalPostsCount = 0
    var stubbedGetLocalPostsResult: [Post]! = []
    func getLocalPosts() -> [Post] {
        invokedGetLocalPosts = true
        invokedGetLocalPostsCount += 1
        return stubbedGetLocalPostsResult
    }
}
