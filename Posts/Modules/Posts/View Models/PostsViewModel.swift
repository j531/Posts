//
//  PostsViewModel.swift
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class PostsViewModel: ReactiveViewModel {

    // MARK: Inputs / outputs

    struct Input {
        let didTapRow: Observable<IndexPath>
    }

    struct Output {
        let rowItems: Observable<[PostRowItem]>
        let isEmpty: Observable<Bool>
        let isLoading: Observable<Bool>
    }

    // MARK: Private properties

    private let navigator: PostsNavigation
    private let postsDomain: PostDomain
    private let disposeBag = DisposeBag()

    // MARK: Initialisation

    init(navigator: PostsNavigation, postsDomain: PostDomain) {
        self.navigator = navigator
        self.postsDomain = postsDomain
    }

    // MARK: Transformation / observation

    func transform(_ input: Input) -> Output? {
        let postsEvents = postsDomain.getRemotePosts()
            .materialize()
            .share()

        let postsRequestDidFail = postsEvents.errors().map { _ in () }

        let localPosts = postsRequestDidFail
            .map { [weak self] _ in self?.postsDomain.getLocalPosts() }
            .unwrap()

        let posts = Observable.merge(postsEvents.elements(), localPosts)

        let postsRowItems = posts
            .map { [weak self] posts -> [PostRowItem] in
                guard let strongSelf = self else { return [] }
                return posts.map(strongSelf.makeRowItem)
        }

        let isLoading = postsEvents
            .map { _ in false }
            .startWith(true)

        let isEmpty = postsRowItems
            .map { $0.isEmpty }
            .startWith(false)

        // Row tapped, push detail module
        input.didTapRow
            .withLatestFrom(posts, resultSelector: { ($0, $1) })
            .subscribe(onNext: { [weak self] indexPath, posts in
                let post = posts[indexPath.row]
                self?.navigator.pushDetail(with: post)
            })
            .disposed(by: disposeBag)

        // Request fails, show error alert
        postsRequestDidFail
            .subscribe(onNext: { [weak self] in
                let title = NSLocalizedString("Something went wrong", comment: "")
                let message = NSLocalizedString("Please check your connection and try again", comment: "")
                self?.navigator.presentAlert(withTitle: title, message: message)
            })
            .disposed(by: disposeBag)

        return Output(rowItems: postsRowItems, isEmpty: isEmpty, isLoading: isLoading)
    }

    // MARK: Helpers

    private func makeRowItem(with post: Post) -> PostRowItem {
        return PostRowItem(title: post.title.capitalized, author: post.user?.username)
    }
}
