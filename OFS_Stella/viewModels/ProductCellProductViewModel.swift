//
//  ProductCellProductViewModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * View model used to bind product model with product cell.
 */
struct ProductCellProductViewModel : ProductCellViewModelInterface {
    private var product : ProductModel
    
    init(product:ProductModel) {
        self.product = product
    }
    
    var name: String { return product.modelNames?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "" }
    var price: String { return product.fullPrice.ofsPriceFormatValue() }
    var imageRequest: ImageRequest { return ImageRequest.thumb(product.defaultCode10) }
}
