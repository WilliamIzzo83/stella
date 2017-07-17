//
//  AppStrings.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Declares application's strings.
 */
enum AppStrings : String {
    case readyToWearTitle = "ready_to_wear_title"
    case accessoriesTitle = "accessories_title"
    case beautyTitle = "beauty_title"
    case lingerieTitle = "lingerie_title"
}

extension AppStrings : Asset {
    typealias T = String
    func get() -> String {
        let key = self.rawValue
        return NSLocalizedString(key, comment: "")
    }
}
