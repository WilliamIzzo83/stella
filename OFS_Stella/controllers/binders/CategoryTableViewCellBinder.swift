//
//  CategoryTableViewCellBinder.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

func categoryTableViewCellBinder(model:IDataModel,
                                 cell:UITableViewCell,
                                 indexPath:IndexPath) {
    let foo = model as! FooModel
    cell.textLabel?.text = foo.title
}
