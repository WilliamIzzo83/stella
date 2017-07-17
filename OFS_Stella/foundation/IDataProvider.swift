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
typealias DataProviderCompletionCallback<T> = (T?, Error?) -> Void

protocol DataProviderToken {}

/**
 * Application will need to get data from different sources. IDataProvider
 * protocol defines an interface for a class of objects able to provide some
 * data.
 */
protocol IDataProvider {
    /// Data carried by provider.
    associatedtype ProviderDataType
    /// Request's data type.
    associatedtype DataRequestPayloadType
    /**
     * Tells provider to get its specific data.
     * - parameter request: contains provider specific request parameter.
     * - parameter didRetrieveDataCallback: callback invoked once that retrieve 
     * data process did end.
     */
    func requestData(request:DataRequestPayloadType,
                      didRetrieveDataCallback:@escaping DataProviderCompletionCallback<ProviderDataType>) -> DataProviderToken
    
    func cancelRequest(token:DataProviderToken)
}

extension Int : DataProviderToken {}

/**
 * Implements data provider protocol as a generic provider class.
 * This implementation does nothing and has to be specialized through
 * inheritance.
 */
class GenericDataProvider<T,U> : IDataProvider {
    typealias ProviderDataType = T
    typealias DataRequestPayloadType = U
    func requestData(request:DataRequestPayloadType,
                      didRetrieveDataCallback: @escaping (T?, Error?) -> Void) -> DataProviderToken { return 0 }
    
    func cancelRequest(token: DataProviderToken) {}
}
