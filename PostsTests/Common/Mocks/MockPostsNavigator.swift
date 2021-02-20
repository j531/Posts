//
//  MockPostsNavigator.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
@testable import Posts

class MockPostsNavigator: PostsNavigation {
    var invokedPushDetail = false
    var invokedPushDetailCount = 0
    var invokedPushDetailParameters: (post: Post, Void)?
    var invokedPushDetailParametersList = [(post: Post, Void)]()
    func pushDetail(with post: Post) {
        invokedPushDetail = true
        invokedPushDetailCount += 1
        invokedPushDetailParameters = (post, ())
        invokedPushDetailParametersList.append((post, ()))
    }
    var invokedPresentAlert = false
    var invokedPresentAlertCount = 0
    var invokedPresentAlertParameters: (title: String, message: String)?
    var invokedPresentAlertParametersList = [(title: String, message: String)]()
    func presentAlert(withTitle title: String, message: String) {
        invokedPresentAlert = true
        invokedPresentAlertCount += 1
        invokedPresentAlertParameters = (title, message)
        invokedPresentAlertParametersList.append((title, message))
    }
    var invokedPresentAlertWithTitle = false
    var invokedPresentAlertWithTitleCount = 0
    var invokedPresentAlertWithTitleParameters: (title: String, message: String, dismissTitle: String)?
    var invokedPresentAlertWithTitleParametersList = [(title: String, message: String, dismissTitle: String)]()
    func presentAlert(withTitle title: String, message: String, dismissTitle: String) {
        invokedPresentAlertWithTitle = true
        invokedPresentAlertWithTitleCount += 1
        invokedPresentAlertWithTitleParameters = (title, message, dismissTitle)
        invokedPresentAlertWithTitleParametersList.append((title, message, dismissTitle))
    }
}
