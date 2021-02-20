//
//  PostWebService.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift

protocol PostWebDataProvider {
    func getPosts() -> Observable<[Post]>
}

class PostWebService: ObjectWebDataProvider, PostWebDataProvider {

    // MARK: Public properties

    var path: String = "posts"

    // MARK: Requests

    func getPosts() -> Observable<[Post]> {
        return getObjects()
    }
}
