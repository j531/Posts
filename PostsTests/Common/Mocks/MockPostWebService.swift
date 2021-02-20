//
//  MockPostWebService.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
@testable import Posts

class MockPostWebService: PostWebDataProvider {
    var invokedGetPosts = false
    var invokedGetPostsCount = 0
    var stubbedGetPostsResult: Observable<[Post]>!
    func getPosts() -> Observable<[Post]> {
        invokedGetPosts = true
        invokedGetPostsCount += 1
        return stubbedGetPostsResult
    }
}
