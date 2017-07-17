//
//  ProductCellViewModelInterface.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Interface representing the display data of a product cell.
 */
protocol ProductCellViewModelInterface : ViewModel {
    /// Product display name.
    var name : String { get }
    /// Product display price.
    var price : String { get }
    /// Product display image request.
    var imageRequest : ImageRequest { get }
}
