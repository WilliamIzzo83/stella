//
//  CategoryCellViewModelInterface.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Interface representing the display data of a category cell.
 */
protocol CategoryCellViewModelInterface : ViewModel {
    /// Display title
    var title : String { get }
    /// Display image
    var image : UIImage { get }
}
