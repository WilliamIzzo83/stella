//
//  DetailViewProductViewModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

class DetailViewProductViewModel : DetailViewPresenter {
    
    private let product : ProductModel
    
    init(product:ProductModel) {
        self.product = product
    }
    
    var title: String { return self.product.modelNames?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "" }
    
    var subtitle: String { return product.fullPrice.ofsPriceFormatValue() }
    
    var imageRequest: ImageRequest { return ImageRequest.detail(product.defaultCode10) }
    
    var subhead: String { return product.macroCategory }
}
