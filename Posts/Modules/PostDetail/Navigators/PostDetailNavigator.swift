//
//  PostDetailNavigator.swift
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import UIKit

protocol PostDetailNavigation: Navigator {
}

class PostDetailNavigator: BaseNavigator, PostDetailNavigation {

    // MARK: Private properties

    private weak var viewController: UIViewController?

    // MARK: Initialisation

    override init(viewController: UIViewController) {
        self.viewController = viewController

        super.init(viewController: viewController)
    }
}
