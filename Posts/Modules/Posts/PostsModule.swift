//
//  PostsModule.swift
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation

struct PostsModule {

    // MARK: Public properties

    let viewController: PostsTableViewController

    // MARK: Build

    static func build() -> PostsModule {
        let viewController = PostsTableViewController()
        let navigator = PostsNavigator(viewController: viewController)
        let postModelController = PostModelController(postsWebService: PostWebService(),
                                                      usersWebService: UserWebService(),
                                                      commentsWebService: CommentWebService(),
                                                      postsStoreService: PostStoreService())
        let viewModel = PostsViewModel(navigator: navigator, postsDomain: postModelController)

        viewController.viewModel = viewModel

        return PostsModule(viewController: viewController)
    }
}
