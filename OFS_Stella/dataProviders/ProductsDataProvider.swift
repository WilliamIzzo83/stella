//
//  ProductsDataProvider.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

extension URLDataProvider {
    static func productsDataProvider(department:Department) -> URLDataProvider {
        
        return URLDataProvider(url: department.url(), decoder: { (data, readyCallback) in
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                print(json)
            } catch {
                readyCallback([], nil) // TODO: report error
            }
        })
    }
}
