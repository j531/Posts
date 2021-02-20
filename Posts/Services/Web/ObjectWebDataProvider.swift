//
//  ObjectWebDataProvider.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire

protocol ObjectWebDataProvider {
    var path: String { get }
}

extension ObjectWebDataProvider {

    // MARK: Public properties

    var baseURL: String { return "https://jsonplaceholder.typicode.com" }

    // MARK: Requests

    func getObjects<T: Decodable>() -> Observable<T> {
        let url = makeURL(withPath: path)

        return RxAlamofire.request(.get, url)
            .validate()
            .decodeResponseData(type: T.self)
    }

    // MARK: Helpers

    private func makeURL(withPath path: String) -> URL {
        guard let url = URL(string: baseURL) else {
            fatalError("\"\(baseURL)\" is not a valid URL")
        }
        return url.appendingPathComponent(path)
    }
}
