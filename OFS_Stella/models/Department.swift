//
//  DepartmentURLs.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Defines store's departments.
 */
enum Department {
    case readyToWear
    case accessories
    case beauty
    case lingerie
}

extension Department {
    /// Gets the api url to retrieve department's data.
    func url() -> URL{
        switch self {
        case .readyToWear:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&gender=D&page=1&department=Main_Ready_To_Wear&format=lite&sortRule=Ranking")!
        case .accessories:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&gender=D&page=1&department=Main_Accessories_All&format=lite&sortRule=Ranking")!
        case .beauty:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&gender=D&page=1&department=Main_Beauty&format=lite&sortRule=Ranking")!
        case .lingerie:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY_IT/search/results.json?ave=prod&productsPerPage=50&page=1&department=Main_Lingerie&format=lite&sortRule=Ranking")!
        }
    }
}

/// Model representing a department.
struct DepartmentModel {
    /// Department's name.
    let name : String
    /// Department's image, taken from application's assets
    let image : AppImages
    /// Department identifier.
    let id : Department
}

