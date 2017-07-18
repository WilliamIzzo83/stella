//
//  AppImages.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Declares application's static images.
 */
enum AppImages : String {
    case readyToWearDepartment = "readytowear"
    case accessoriesDepartment = "accessories"
    case beautyDepartment = "beauty"
    case lingerieDepartment = "lingerie"
    case placeholder = "placeholder"
}

extension AppImages : Asset {
    typealias T = UIImage
    func get() -> UIImage {
        return UIImage(named: self.rawValue)!
    }
}
