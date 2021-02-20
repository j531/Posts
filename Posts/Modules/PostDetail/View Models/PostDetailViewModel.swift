//
//  PostDetailViewModel.swift
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import RxSwift

class PostDetailViewModel: ReactiveViewModel {

    // MARK: Inputs / outputs

    struct Input {
    }

    struct Output {
        let rowItems: Observable<[Any]>
    }

    // MARK: Private properties

    private let post: Post
    private let navigator: PostDetailNavigation
    private let disposeBag = DisposeBag()

    // MARK: Initialisation

    init(navigator: PostDetailNavigation, post: Post) {
        self.post = post
        self.navigator = navigator
    }

    // MARK: Transformation / observation

    func transform(_ input: Input) -> Output? {
        var rowItems: [Any] = [
            PostDetailTitleRowItem(title: post.title, author: post.user?.username),
            PostDetailBodyRowItem(body: post.body),
            PostDetailCommentsInfoItem(title: "\(post.comments.count) " + NSLocalizedString("comments", comment: ""))
        ]

        for comment in post.comments {
            let commentItem = PostDetailCommentItem(author: comment.name, comment: comment.body)
            rowItems.append(commentItem)
        }

        return Output(rowItems: Observable.just(rowItems))
    }
}
