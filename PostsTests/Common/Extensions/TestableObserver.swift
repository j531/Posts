//
//  TestableObserver.swift
//  PostsTests
//
//  Created by Joshua Simmons on 21/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import RxTest

// MARK: - Helpers

extension TestableObserver {

    var elements: [Element] {
        return events.compactMap { $0.value.element }
    }
}
