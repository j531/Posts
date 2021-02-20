//
//  PostsNavigator.swift
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import UIKit

protocol PostsNavigation: Navigator {
    func pushDetail(with post: Post)
}

class PostsNavigator: BaseNavigator, PostsNavigation {

    // MARK: Private properties

    private weak var viewController: UIViewController?

    // MARK: Initialisation

    override init(viewController: UIViewController) {
        self.viewController = viewController

        super.init(viewController: viewController)
    }

    // MARK: Navigation

    func pushDetail(with post: Post) {
        let detailController = PostDetailModule.build(with: post).viewController
        viewController?.navigationController?.pushViewController(detailController, animated: true)
    }
}
