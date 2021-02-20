//
//  ReactiveViewModel.swift
//  Posts
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation

protocol ReactiveViewModel {
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output?
}
