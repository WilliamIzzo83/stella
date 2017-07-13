//
//  FooModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

let FooModelType = 0

struct FooModel : IDataModel {
    var id: String
    var title : String
    
    static var type : Int { return FooModelType }
    
    init(identifier:String) {
        id = identifier
        title = ""
    }
    
    init(identifier:String, title:String) {
        self.id = identifier
        self.title = title
    }
}
