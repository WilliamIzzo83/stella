//
//  DepartmentCategoryCellViewModel.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * View model used to bind a department model with category cell.
 */
struct DepartmentCategoryCellViewModel : CategoryCellViewModelInterface {
    private var department : DepartmentModel
    
    var title: String {
        return self.department.name }
    var image: UIImage { return self.department.image.get() }
    
    init(department:DepartmentModel) {
        self.department = department
    }
}
