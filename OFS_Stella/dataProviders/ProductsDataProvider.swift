//
//  ProductsDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/// Struct representing API Header data field. Used for api's data decoding.
struct RequestResponseHeader : Codable {
    let statusCode : Int
    let description : String
    
    private enum CodingKeys : String, CodingKey {
        case statusCode = "StatusCode"
        case description = "Description"
    }
}

/// Struct representing ResultsLite field. Used for api's data decoding.
struct ResultsLiteResponse : Codable {
    let totalResults : Int
    let items : [ProductModel]
    
    private enum CodingKeys : String, CodingKey {
        case totalResults = "TotalResults"
        case items = "Items"
    }
}

/// Strict representing the whole api's product data. Used for decoding.
struct ProductRequestResponse : Codable {
    let header : RequestResponseHeader
    let resultsLite : ResultsLiteResponse
    
    private enum CodingKeys : String, CodingKey {
        case header = "Header"
        case resultsLite = "ResultsLite"
    }
}

extension HTTPDataProvider {
    /// Returns a data provider that retrieves products from the remote api
    static func productsDataProvider(department:Department) -> HTTPDataProvider<[ProductModel]> {
        return HTTPDataProvider<[ProductModel]>(url: department.url(), decoder: { (data, readyCallback) in
            do {
                let jsonDecoder = JSONDecoder()
                let productRsp = try jsonDecoder.decode(ProductRequestResponse.self, from: data)
                
                readyCallback(productRsp.resultsLite.items, nil)
            } catch {
                readyCallback([], error) // TODO: report error
            }
        })
    }
}
