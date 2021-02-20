//
//  MockUserWebService.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
@testable import Posts

class MockUserWebService: UserWebDataProvider {
    var invokedGetUsers = false
    var invokedGetUsersCount = 0
    var stubbedGetUsersResult: Observable<[User]>!
    func getUsers() -> Observable<[User]> {
        invokedGetUsers = true
        invokedGetUsersCount += 1
        return stubbedGetUsersResult
    }
}
