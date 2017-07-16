//
//  ProductCellProductViewModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

struct ProductCellProductViewModel : ProductCellPresenter {
    private var product : ProductModel
    
    init(product:ProductModel) {
        self.product = product
    }
    
    var name: String { return product.modelNames ?? "" }
    var price: String { return "\(product.fullPrice) €" }
    var imageRequest: ImageRequest { return ImageRequest.thumb(product.defaultCode10) }
}
