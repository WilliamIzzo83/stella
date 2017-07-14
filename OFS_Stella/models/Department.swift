//
//  DepartmentURLs.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

enum Department {
    case readyToWear
    case accessories
    case beauty
    case lingerie
}

extension Department {
    func url() -> URL{
        switch self {
        case .readyToWear:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY/search/results.json?ave=prod&productsPerPage=50&gender=D&page=18&department=Main_Ready_To_Wear&format=lite&sortRule=Ranking")!
        case .accessories:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY/search/results.json?ave=prod&productsPerPage=50&gender=D&page=18&department=Main_Accessories_All&format=lite&sortRule=Ranking")!
        case .beauty:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY/search/results.json?ave=prod&productsPerPage=50&gender=D&page=18&department=Main_Beauty&format=lite&sortRule=Ranking")!
        case .lingerie:
            return URL(string:"http://api.yoox.biz/Search.API/1.3/STELLAMCCARTNEY/search/results.json?ave=prod&productsPerPage=50&page=18&department=Main_Lingerie&format=lite&sortRule=Ranking")!
        }
    }
}


let DepartmentModelType = 2

struct DepartmentModel : IDataModel {
    let name : String
    let image : AppImages
    
    static var type: Int {
        return DepartmentModelType
    }
}

