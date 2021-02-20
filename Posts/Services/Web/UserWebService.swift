//
//  UserWebService.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift

protocol UserWebDataProvider {
    func getUsers() -> Observable<[User]>
}

class UserWebService: ObjectWebDataProvider, UserWebDataProvider {

    // MARK: Public properties

    var path: String = "users"

    // MARK: Requests

    func getUsers() -> Observable<[User]> {
        return getObjects()
    }
}
