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
 * - parameter data: contains retrieved data.
 * - parameter error: if not nil means that an error has occurred during data
 * retrieval
 */
typealias DataProviderCompletionCallback<T> = (_ data:T?, _ error:Error?) -> Void

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
     *
     * - returns: a token that can be used for request operation canceling.
     */
    func requestData(request:DataRequestPayloadType,
                      didRetrieveDataCallback:@escaping DataProviderCompletionCallback<ProviderDataType>) -> DataProviderToken
    
    /**
     * Cancels a previous data request. Implementation should use the token as
     * a mean to identify what request needs to be canceled.
     * - parameter token: a token identifying the request that needs to be
     * canceled.
     */
    func cancelRequest(token:DataProviderToken)
}

extension Int : DataProviderToken {}

/**
 * Implements data provider protocol as a generic provider class.
 * This implementation does nothing and has to be specialized through
 * inheritance in order to be used in any meaningful way.
 */
class GenericDataProvider<T,U> : IDataProvider {
    typealias ProviderDataType = T
    typealias DataRequestPayloadType = U
    func requestData(request:DataRequestPayloadType,
                     didRetrieveDataCallback:@escaping DataProviderCompletionCallback<ProviderDataType>) -> DataProviderToken { return 0 }
    
    func cancelRequest(token: DataProviderToken) {}
}
