//
//  ObservableType.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

// MARK: - RxAlamofire

extension ObservableType where Element == DataRequest {

    func decodeResponseData<T: Decodable>(type: T.Type) -> Observable<T> {
        return responseData().decode(type: type)
    }
}

extension ObservableType where Element == (HTTPURLResponse, Data) {

    func decode<T: Decodable>(type: T.Type) -> Observable<T> {
        return map { data -> T in
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data.1)
            return object
        }
    }
}
