//
//  PostModelController.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol PostDomain {
    func getRemotePosts() -> Observable<[Post]>
    func getLocalPosts() -> [Post]
}

class PostModelController: PostDomain {

    // MARK: Private properties

    private let postsWebService: PostWebDataProvider
    private let usersWebService: UserWebDataProvider
    private let commentsWebService: CommentWebDataProvider
    private let postsStoreService: PostStoredDataProvider

    // MARK: Initialisation

    init(postsWebService: PostWebDataProvider,
         usersWebService: UserWebDataProvider,
         commentsWebService: CommentWebDataProvider,
         postsStoreService: PostStoredDataProvider) {

        self.postsWebService = postsWebService
        self.usersWebService = usersWebService
        self.commentsWebService = commentsWebService
        self.postsStoreService = postsStoreService
    }

    // MARK: Data

    func getRemotePosts() -> Observable<[Post]> {
        // Get posts, get users, get comments, build relationships, store everything, return posts
        let posts = postsWebService.getPosts()
        let users = usersWebService.getUsers()
        let comments = commentsWebService.getComments()

        return Observable.zip(posts, users, comments)
            .do(onNext: { [weak self] posts, users, comments in
                self?.assign(users, to: posts)
                self?.assign(comments, to: posts)
                self?.postsStoreService.storeObjects(posts)
                self?.postsStoreService.storeObjects(users) // All storeServices can store Objects of any type...
                self?.postsStoreService.storeObjects(comments) // ...
            })
            .map({ posts, _, _ in posts })
    }

    func getLocalPosts() -> [Post] {
        return postsStoreService.getPosts()
    }

    // MARK: Helpers

    private func assign(_ users: [User], to posts: [Post]) {
        let usersToIds = assignObjectsToIds(users)
        for post in posts {
            let user = usersToIds[post.userId]
            if user == nil {
                print("User \(post.userId) not found.")
            }
            post.user = user
        }
    }

    private func assign(_ comments: [Comment], to posts: [Post]) {
        let postsToIds = assignObjectsToIds(posts)
        for comment in comments {
            guard let post = postsToIds[comment.postId] else {
                print("Post \(comment.postId) not found.")
                continue
            }
            post.comments.append(comment)
        }
    }

    private func assignObjectsToIds<T: HasIntId>(_ objects: [T]) -> [Int: T] {
        return objects.reduce([Int: T]()) { (result, object) -> [Int: T] in
            var result = result
            result[object.id] = object
            return result
        }
    }
}

private protocol HasIntId {
    var id: Int { get }
}

extension User: HasIntId {}
extension Post: HasIntId {}
