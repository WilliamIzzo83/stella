//
//  URLDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/// Typealias for a function which transforms raw data into generic function's
/// type
/// - parameter data: raw data bytes.
/// - parameter didDecodeData: a decoding closure.
/// - parameter model: decoded data.
/// - parameter error: parametrized if a decoding error occurred.
typealias URLDataProviderDecoder<T> = (_ data: Data, _ didDecodeData: (_ model:T, _ error:Error?) -> Void) -> Void

extension URLSessionTask : DataProviderToken {}

/**
 * URLDataProvider implements a data provider that retrieves the data from an
 * url. Once raw data is obtained from the url, the provider will pass through
 * a *dataModelDecoder* which decodes the data into the specified generic type.
 */
class HTTPDataProvider<T> : GenericDataProvider<T, Void> {
    
    /// This is the url where data is located
    private var dataURL : URL
    
    /// Each data provider has its own url session
    private var urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    /// Decoding closure.
    var dataModelDecoder : URLDataProviderDecoder<T>
    
    /**
     * Initializes the url provider. 
     * - parameter url: data location
     * - parameter decoder: the designated data decoder.
     */
    init(url:URL, decoder:@escaping URLDataProviderDecoder<T>) {
        dataURL = url
        dataModelDecoder = decoder
    }
    
    override func requestData(request:Void,
                     didRetrieveDataCallback:@escaping DataProviderCompletionCallback<T>) -> DataProviderToken {
        let task = urlSession.dataTask(with: dataURL) { [weak self](data, response, error) in
            guard error == nil else {
                didRetrieveDataCallback(nil, error)
                return
            }
            
            // TODO: check http status code
            
            self?.dataModelDecoder(data!) {
                didRetrieveDataCallback($0, $1)
            }
        }
        
        task.resume()
        return task
    }
    
    override func cancelRequest(token: DataProviderToken) {
        let task = token as! URLSessionTask
        task.cancel()
    }
}
