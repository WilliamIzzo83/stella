//
//  URLDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/// Typealias for a function which transforms raw data into an array of
/// *IDataModel*
typealias URLDataProviderDecoder<T> = (_ data: Data, _ didDecodeData: (_ models:T, _ error:Error?) -> Void) -> Void

/**
 * URLDataProvider implements a data provider that retrieves the data from an
 * url. Once raw data is obtained from the url, the provider will pass through
 * a *dataModelDecoder* which decodes the data into an array of *IDataModel*.
 */
class URLDataProvider<T> : GenericDataProvider<T> {
    
    /// This is the url where data is located
    private var dataURL : URL
    
    /// Each data provider has its own url session
    private var urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    /// This decodes data into an array of *IDataModel* when it gets ready.
    var dataModelDecoder : URLDataProviderDecoder<T>
    
    /**
     * Initializes the url provider. 
     * - parameter url: data location
     * - parameter decoder: the designated decoder that transforms the raw data
     * into an array of *IDataModel* objects
     */
    init(url:URL, decoder:@escaping URLDataProviderDecoder<T>) {
        dataURL = url
        dataModelDecoder = decoder
    }
    
    override func retrieveData(didRetrieveDataCallback: @escaping (T?, Error?) -> Void) {
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
    }
}
