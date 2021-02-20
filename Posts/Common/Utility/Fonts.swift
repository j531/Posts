//
//  Fonts.swift
//  Posts
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2019 Joshua. All rights reserved.
//

import Foundation
import UIKit

enum Fonts: String {

    // MARK: Values

    case avenirNext = "Avenir Next"
    case optima = "Optima"

    // MARK: Creation

    func ofSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let descriptor = UIFontDescriptor(fontAttributes: [
            .family: rawValue,
            .traits: [UIFontDescriptor.TraitKey.weight: weight]
            ])
        return UIFont(descriptor: descriptor, size: size)
    }
}
