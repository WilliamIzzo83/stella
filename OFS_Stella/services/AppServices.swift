//
//  AppServices.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Statically exposes some application's shared services
 */
class AppServices {
    /// Shared umage provider used among application's components
    static let imagesProvider = ProductImagesProvider.default()
}


extension Int {
    /// Formats an int to be represented as a price.
    func ofsPriceFormatValue() -> String {
        return "€ \(NumberFormatter.localizedString(from:NSNumber(value:self), number: .decimal))"
    }
}
