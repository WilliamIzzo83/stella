//
//  AppServices.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

class AppServices {
    static let imagesProvider = ProductImagesProvider()
}


extension Int {
    func ofsPriceFormatValue() -> String {
        return "€ \(NumberFormatter.localizedString(from:NSNumber(value:self), number: .decimal))"
    }
}
