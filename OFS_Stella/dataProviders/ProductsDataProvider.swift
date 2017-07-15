//
//  ProductsDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

struct RequestResponseHeader : Codable {
    let statusCode : Int
    let description : String
    
    private enum CodingKeys : String, CodingKey {
        case statusCode = "StatusCode"
        case description = "Description"
    }
}

struct ResultsLiteResponse : Codable {
    let totalResults : Int
    let items : [ProductModel]
    
    private enum CodingKeys : String, CodingKey {
        case totalResults = "TotalResults"
        case items = "Items"
    }
}

struct ProductRequestResponse : Codable {
    let header : RequestResponseHeader
    let resultsLite : ResultsLiteResponse
    
    private enum CodingKeys : String, CodingKey {
        case header = "Header"
        case resultsLite = "ResultsLite"
    }
}

extension URLDataProvider {
    static func productsDataProvider(department:Department) -> URLDataProvider<[ProductModel]> {
        return URLDataProvider<[ProductModel]>(url: department.url(), decoder: { (data, readyCallback) in
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
