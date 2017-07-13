//
//  NullDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

class NullDataProvider : IDataProvider {
    func retrieveData(didRetrieveDataCallback: ([IDataModel], Error?) -> Void) {
        didRetrieveDataCallback([],nil)
    }
}
