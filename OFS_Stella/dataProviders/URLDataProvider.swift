//
//  URLDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Defines an interface for object that are able to decode a set of IDataModel
 * objects from raw data.
 */
protocol IDataModelDecoder {
    /**
     * Begins data decoding. Once decoding ends the *didDecodeData* callback is
     * invoked.
     */
    func decode(data:Data, didDecodeData:([IDataModel], Error?) -> Void)
}

/// Typealias for a function which transforms raw data into an array of 
/// *IDataModel*
typealias URLDataProviderDecoder = (_ data: Data, _ didDecodeData: (_ models:[IDataModel], _ error:Error?) -> Void) -> Void

/**
 * URLDataProvider implements a data provider that retrieves the data from an
 * url. Once raw data is obtained from the url, the provider will pass through
 * a *dataModelDecoder* which decodes the data into an array of *IDataModel*.
 */
class URLDataProvider : IDataProvider {
    
    /// This is the url where data is located
    private var dataURL : URL
    
    /// Each data provider has its own url session
    private var urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
    /// This decodes data into an array of *IDataModel* when it gets ready.
    var dataModelDecoder : URLDataProviderDecoder
    
    /**
     * Initializes the url provider. 
     * - parameter url: data location
     * - parameter decoder: the designated decoder that transforms the raw data
     * into an array of *IDataModel* objects
     */
    init(url:URL, decoder:@escaping URLDataProviderDecoder) {
        dataURL = url
        dataModelDecoder = decoder
    }
    
    func retrieveData(didRetrieveDataCallback: @escaping ([IDataModel], Error?) -> Void) {
        let task = urlSession.dataTask(with: dataURL) { [weak self](data, response, error) in
            guard error == nil else {
                didRetrieveDataCallback([], error)
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
