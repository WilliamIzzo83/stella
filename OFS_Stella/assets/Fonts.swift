//
//  Fonts.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Declares application's fonts.
 */
enum Fonts {
    case title
    case headline
    case body
    case macrocategory
}

extension Fonts : Asset {
    typealias T = UIFont
    /**
     * - Warning: the get function is a little bit crowded with ios version
     * control in order to support font displaying on ios8.
     */
    func get() -> UIFont {
        switch self {
        case .title:
            if #available(iOS 9.0, *) {
                return UIFont.preferredFont(forTextStyle: .title2)
            } else {
                return UIFont.systemFont(ofSize: 20.0)
            }
        case .headline:
            if #available(iOS 9.0, *) {
                return UIFont.preferredFont(forTextStyle: .headline)
            } else {
                return UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
            }
        case .body:
            if #available(iOS 9.0, *) {
                return UIFont.preferredFont(forTextStyle: .body)
            } else {
                return UIFont.systemFont(ofSize: UIFont.labelFontSize)
            }
        case .macrocategory:
            return UIFont.italicSystemFont(ofSize: 12.0)
        }
    }
}
