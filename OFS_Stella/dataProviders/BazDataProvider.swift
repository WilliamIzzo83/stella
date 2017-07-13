//
//  BazDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

class BazDataProvider : IDataProvider {
    func retrieveData(didRetrieveDataCallback: ([IDataModel], Error?) -> Void) {
        didRetrieveDataCallback([
            FooModel(identifier: "1234", title: "Product one"),
            FooModel(identifier: "2234", title: "Product two"),
            FooModel(identifier: "3234", title: "Product three"),
            FooModel(identifier: "3234", title: "Product Four"),
        ], nil)
    }
}
