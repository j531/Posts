//
//  PostModelControllerTests.swift
//  PostsTests
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Posts

class PostModelControllerTests: XCTestCase {

    // MARK: Private properties

    private var components = makeComponents()
    private var disposeBag = DisposeBag()

    // MARK: Setup

    override func setUp() {
        super.setUp()

        components = PostModelControllerTests.makeComponents()
        disposeBag = DisposeBag()
    }

    // MARK: Tests

    func testGetRemotePostsCount() {
        let posts = setupMockWebServiceComponentsBehaviour()
        let scheduler = TestScheduler(initialClock: 0)

        // Ensure all posts are returned from webservice
        let postsObserver = scheduler.createObserver([Post].self)
        components.postController.getRemotePosts().subscribe(postsObserver).disposed(by: disposeBag)
        XCTAssertEqual(postsObserver.elements.first?.count, posts.count)
    }

    func testGetRemotePostsRelationships() {
        setupMockWebServiceComponentsBehaviour()
        let scheduler = TestScheduler(initialClock: 0)
        let postsObserver = scheduler.createObserver([Post].self)
        components.postController.getRemotePosts().subscribe(postsObserver).disposed(by: disposeBag)

        // Ensure user is properly assigned
        let retrievedPosts = postsObserver.elements.first!
        let firstPost = retrievedPosts.first!
        XCTAssertEqual(firstPost.user?.id, firstPost.userId)

        // Ensure all comment postIds are correct
        let commentsIdsAreCorrect = firstPost.comments.allSatisfy { $0.postId == firstPost.id }
        XCTAssertTrue(commentsIdsAreCorrect)
    }

    func testObjectsPersisted() {
        let posts = setupMockWebServiceComponentsBehaviour()
        let scheduler = TestScheduler(initialClock: 0)

        // No objects stored
        XCTAssertTrue(components.postStoreService.invokedStoreObjectsParametersList.isEmpty)

        // After retrieving posts, posts, users and comments should now be stored
        let postsObserver = scheduler.createObserver([Post].self)
        components.postController.getRemotePosts().subscribe(postsObserver).disposed(by: disposeBag)

        let totalObjectsCount =
            posts.count + // posts count
            posts.count + // users count
            posts.reduce(0, { $0 + $1.comments.count }) // comments count

        let totalStored = components.postStoreService.invokedStoreObjectsParametersList.reduce(0, { $0 + $1.objects.count })

        XCTAssertEqual(totalStored, totalObjectsCount)
    }

    // MARK: Helpers

    @discardableResult
    private func setupMockWebServiceComponentsBehaviour() -> [Post] {
        let postCount = 20
        let posts = (0..<postCount).map { Post.makeFixture(withId: $0) }
        let users = posts.map { $0.user! }
        let comments = posts.flatMap { $0.comments }

        // "Clean" posts
        for post in posts {
            post.comments.removeAll()
            post.user = nil
        }

        components.postWebService.stubbedGetPostsResult = Observable.just(posts)
        components.userWebService.stubbedGetUsersResult = Observable.just(users)
        components.commentWebService.stubbedGetCommentsResult = Observable.just(comments)
        return posts
    }

    private static func makeComponents() -> (
        postController: PostModelController,
        postWebService: MockPostWebService,
        userWebService: MockUserWebService,
        commentWebService: MockCommentWebService,
        postStoreService: MockPostStoreService) {

            let postWebService = MockPostWebService()
            let userWebService = MockUserWebService()
            let postStoreService = MockPostStoreService()
            let commentWebService = MockCommentWebService()
            let postController = PostModelController(postsWebService: postWebService,
                                                     usersWebService: userWebService,
                                                     commentsWebService: commentWebService,
                                                     postsStoreService: postStoreService)
            return (postController, postWebService, userWebService, commentWebService, postStoreService)
    }
}
