//
//  PostsViewModelTests.swift
//  PostsTests
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Posts

class PostsViewModelTests: XCTestCase {

    // MARK: Private properties

    private var components = makeComponents()
    private var disposeBag = DisposeBag()

    // MARK: Setup

    override func setUp() {
        super.setUp()

        components = PostsViewModelTests.makeComponents()
        disposeBag = DisposeBag()
    }

    // MARK: Tests

    func testLoadingStateChanged() {
        let postsRequestSubject = PublishSubject<[Post]>()
        components.postsController.stubbedGetRemotePostsResult = postsRequestSubject

        let inputs = makeSubjectInputs()
        let outputs = components.viewModel.transform(inputs.viewModelInputs)
        let testScheduler = TestScheduler(initialClock: 0)

        // Loading state on
        let loadingObserver = testScheduler.createObserver(Bool.self)
        outputs?.isLoading.subscribe(loadingObserver).disposed(by: disposeBag)
        XCTAssertTrue(loadingObserver.elements.last!)

        // Get posts, loading now off
        let posts = (0..<30).map { _ in Post.makeFixture() }
        postsRequestSubject.onNext(posts)
        XCTAssertFalse(loadingObserver.elements.last!)
    }

    func testEmptyStateChanged() {
        let postsRequestSubject = PublishSubject<[Post]>()
        components.postsController.stubbedGetRemotePostsResult = postsRequestSubject

        let inputs = makeSubjectInputs()
        let outputs = components.viewModel.transform(inputs.viewModelInputs)
        let testScheduler = TestScheduler(initialClock: 0)

        // Not empty state shown initially (loading)
        let emptyObserver = testScheduler.createObserver(Bool.self)
        outputs?.isEmpty.subscribe(emptyObserver).disposed(by: disposeBag)
        XCTAssertFalse(emptyObserver.elements.last!)

        // Get 0 posts, empty state now shown
        postsRequestSubject.onNext([])
        XCTAssertTrue(emptyObserver.elements.last!)
    }

    func testRemotePostsShown() {
        let postsRequestSubject = PublishSubject<[Post]>()
        components.postsController.stubbedGetRemotePostsResult = postsRequestSubject

        let inputs = makeSubjectInputs()
        let outputs = components.viewModel.transform(inputs.viewModelInputs)
        let testScheduler = TestScheduler(initialClock: 0)

        // No row items initially
        let rowItemsObserver = testScheduler.createObserver([PostRowItem].self)
        outputs?.rowItems.subscribe(rowItemsObserver).disposed(by: disposeBag)
        XCTAssertTrue(rowItemsObserver.elements.isEmpty)

        // Remote posts retrieved, row items should be emitted
        let posts = (0..<30).map { _ in Post.makeFixture() }
        postsRequestSubject.onNext(posts)
        XCTAssertEqual(rowItemsObserver.elements.last!.count, 30)
    }

    func testLocalPostsFallBack() {
        let postsRequestSubject = PublishSubject<[Post]>()
        components.postsController.stubbedGetRemotePostsResult = postsRequestSubject
        let posts = (0..<15).map { _ in Post.makeFixture() }
        components.postsController.stubbedGetLocalPostsResult = posts

        let inputs = makeSubjectInputs()
        let outputs = components.viewModel.transform(inputs.viewModelInputs)
        let testScheduler = TestScheduler(initialClock: 0)

        // No row items initially
        let rowItemsObserver = testScheduler.createObserver([PostRowItem].self)
        outputs?.rowItems.subscribe(rowItemsObserver).disposed(by: disposeBag)
        XCTAssertTrue(rowItemsObserver.elements.isEmpty)

        // Remote posts fails, local posts retrieved, row items should be emitted
        postsRequestSubject.onError("Fail")
        XCTAssertEqual(rowItemsObserver.elements.last!.count, 15)
    }

    func testTappingPost() {
        let inputs = makeSubjectInputs()
        let posts = (0..<30).map { _ in Post.makeFixture() }
        components.postsController.stubbedGetRemotePostsResult = Observable.just(posts)
        _ = components.viewModel.transform(inputs.viewModelInputs)

        // Navigator not asked to push
        XCTAssertFalse(components.navigator.invokedPushDetail)

        // Ensure post in third row tapped and navigator push method called with this post
        inputs.didTapRow.onNext(IndexPath(row: 2, section: 0))
        let tappedPostId = components.navigator.invokedPushDetailParameters!.post.id
        XCTAssertEqual(tappedPostId, posts[2].id)
    }

    // MARK: Helpers

    private static func makeComponents() -> (
        viewModel: PostsViewModel,
        postsController: MockPostModelController,
        navigator: MockPostsNavigator) {

            let navigator = MockPostsNavigator()
            let postsController = MockPostModelController()
            let viewModel = PostsViewModel(navigator: navigator, postsDomain: postsController)
            return (viewModel, postsController, navigator)
    }

    private func makeSubjectInputs() -> (viewModelInputs: PostsViewModel.Input, didTapRow: PublishSubject<IndexPath>) {
        let didTapRow = PublishSubject<IndexPath>()
        let inputs = PostsViewModel.Input(didTapRow: didTapRow)
        return (inputs, didTapRow)
    }
}


