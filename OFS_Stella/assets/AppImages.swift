//
//  AppImages.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

enum AppImages {
    case readyToWearDepartment
    case accessoriesDepartment
    case beautyDepartment
    case lingerieDepartment
}

extension AppImages : Asset {
    typealias T = UIImage
    func get() -> UIImage {
        switch self {
        case .readyToWearDepartment:
            return UIImage()
        case .accessoriesDepartment:
            return UIImage()
        case .beautyDepartment:
            return UIImage()
        case .lingerieDepartment:
            return UIImage()
        }
    }
}
