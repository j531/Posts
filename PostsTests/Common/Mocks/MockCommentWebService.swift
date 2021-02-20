//
//  MockCommentWebService.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
@testable import Posts

class MockCommentWebService: CommentWebDataProvider {
    var invokedGetComments = false
    var invokedGetCommentsCount = 0
    var stubbedGetCommentsResult: Observable<[Comment]>!
    func getComments() -> Observable<[Comment]> {
        invokedGetComments = true
        invokedGetCommentsCount += 1
        return stubbedGetCommentsResult
    }
}
