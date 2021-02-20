//
//  PostDetailModule.swift
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation

struct PostDetailModule {

    // MARK: Public properties

    let viewController: PostDetailTableViewController

    // MARK: Build

    static func build(with post: Post) -> PostDetailModule {
        let viewController = PostDetailTableViewController()
        let navigator = PostDetailNavigator(viewController: viewController)
        let viewModel = PostDetailViewModel(navigator: navigator, post: post)

        viewController.viewModel = viewModel

        return PostDetailModule(viewController: viewController)
    }
}
