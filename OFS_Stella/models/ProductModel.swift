//
//  ProductModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 14/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

struct ProductSizes : Codable {
    let text : String
    let classFamily : String
    
    private enum CodingKeys : String, CodingKey {
        case text = "Text"
        case classFamily = "ClassFamily"
    }
}

struct ProductColor : Codable {
    let id : Int
    
    private enum CodingKeys : String, CodingKey {
        case id = "Id"
    }
}
let ProductModelType = 3
struct ProductModel : IDataModel, Codable {
    
    static var type: Int {
        return ProductModelType
    }
    
    let code8 : String
    let brandName : String
    let defaultCode10 : String
    let microCategory : String
    let macroCategory : String
    let fullPrice : Int
    let discountedPrice : Int
    let modelNames : String?
    let sizes : [ProductSizes]
    let colors : [ProductColor]
    
    private enum CodingKeys : String, CodingKey{
        case code8 = "Code8"
        case brandName = "BrandName"
        case defaultCode10 = "DefaultCode10"
        case microCategory = "MicroCategory"
        case macroCategory = "MacroCategory"
        case fullPrice = "FullPrice"
        case discountedPrice = "DiscountedPrice"
        case modelNames = "ModelNames"
        case sizes = "Sizes"
        case colors = "Colors"
    }
}