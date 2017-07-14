//
//  IDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Callback invoked by a data provider once data retrieval process gets 
 * completed.
 */
typealias DataProviderCompletionCallback = ([IDataModel], Error?) -> Void

/**
 * Application will need to get data from different sources. IDataProvider
 * protocol defines an interface for a class of objects able to provide some
 * data.
 */
protocol IDataProvider {
    /**
     * Tells provider to get its specific data.
     * - parameter didRetrieveDataCallback: callback invoked once that retrieve 
     * data process did end.
     */
    func retrieveData(didRetrieveDataCallback:@escaping DataProviderCompletionCallback)
}
