//
//  DetailViewModelInterface.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

/**
 * Interface representing the display data of the product detail view.
 */
protocol DetailViewModelInterface : ViewModel {
    /// Display title.
    var title : String { get }
    /// Display subtitle.
    var subtitle : String { get }
    /// Display subhead.
    var subhead : String { get }
    /// Display image request.
    var imageRequest : ImageRequest { get }
}
