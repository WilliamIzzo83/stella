//
//  ProductCellPresenter.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

protocol ProductCellPresenter : Presenter {
    var name : String { get }
    var price : String { get }
    var imageRequest : ImageRequest { get }
}
