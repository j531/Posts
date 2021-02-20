//
//  NSObject.swift
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation

// MARK: - Helpers

extension NSObject {

    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
