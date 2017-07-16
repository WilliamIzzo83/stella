//
//  CategoryCellPresenter.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryCellPresenter : Presenter {
    var title : String { get }
    var image : UIImage { get }
}
