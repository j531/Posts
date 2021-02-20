//
//  CommentWebService.swirt
//  Posts
//
//  Created by Joshua Simmons on 1t/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift

protocol CommentWebDataProvider {
    func getComments() -> Observable<[Comment]>
}

class CommentWebService: ObjectWebDataProvider, CommentWebDataProvider {

    // MARK: Public properties

    var path: String = "comments"

    // MARK: Requests

    func getComments() -> Observable<[Comment]> {
        return getObjects()
    }
}
