//
//  Post.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
@testable import Posts

// MARK: - Fixtures

extension Post {

    static func makeFixture(withId id: Int = 0) -> Post {
        let post = Post()
        post.id = id
        post.title = "Test Title"
        post.body = "Test Body"

        let user = User()
        user.username = "Test Username"
        post.user = user

        let comments = (0..<15).map { i -> Comment in
            let comment = Comment()
            comment.postId = post.id
            comment.body = "Test Comment \(i)"
            comment.name = "Test name \(i)"
            return comment
        }
        post.comments.append(objectsIn: comments)

        return post
    }
}
