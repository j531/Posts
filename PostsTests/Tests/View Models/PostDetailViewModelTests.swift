//
//  PostDetailViewModelTests.swift
//  PostsTests
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import Posts

class PostDetailViewModelTests: XCTestCase {

    // MARK: Private properties

    private var components = makeComponents()
    private var disposeBag = DisposeBag()

    // MARK: Setup

    override func setUp() {
        super.setUp()

        components = PostDetailViewModelTests.makeComponents()
        disposeBag = DisposeBag()
    }

    // MARK: Tests

    func testArticleStructure() {
        let outputs = components.viewModel.transform(PostDetailViewModel.Input())
        let testScheduler = TestScheduler(initialClock: 0)

        // Row items should represent article state
        let rowItemsObserver = testScheduler.createObserver([Any].self)
        outputs?.rowItems.subscribe(rowItemsObserver).disposed(by: disposeBag)

        let titleItem = rowItemsObserver.elements.first![0] as! PostDetailTitleRowItem
        XCTAssertEqual(titleItem.title, components.post.title)
        XCTAssertEqual(titleItem.author, components.post.user!.username)

        let bodyItem = rowItemsObserver.elements.first![1] as! PostDetailBodyRowItem
        XCTAssertEqual(bodyItem.body, components.post.body)

        let commentInfoItem = rowItemsObserver.elements.first![2] as! PostDetailCommentsInfoItem
        XCTAssertEqual(commentInfoItem.title, "\(components.post.comments.count) comments")

        // Rest should be comment items
        let totalRowsCount = rowItemsObserver.elements.first!.count
        let commentItems = Array(rowItemsObserver.elements.first![3..<totalRowsCount]) as! [PostDetailCommentItem]
        XCTAssertEqual(commentItems.count, components.post.comments.count)

        let firstCommentItem = commentItems.first
        XCTAssertEqual(firstCommentItem?.comment, components.post.comments.first?.body)
        XCTAssertEqual(firstCommentItem?.author, components.post.comments.first?.name)
    }

    // MARK: Helpers

    private static func makeComponents() -> (viewModel: PostDetailViewModel, post: Post) {
        let post = Post.makeFixture()
        let navigator = MockPostDetailNavigator()
        let viewModel = PostDetailViewModel(navigator: navigator, post: post)
        return (viewModel, post)
    }
}
