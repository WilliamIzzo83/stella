//
//  TableViewCellBinder.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellBinder {
    private typealias BindFunction = (IDataModel,UITableViewCell,IndexPath) -> Void
    
    private static let bindersMap : [CellsIdentifiers:BindFunction] = [
        .categoryCell  : categoryTableViewCellBinder,
        .productCell : productTableViewCellBinder
    ]
    
    static func bind(model:IDataModel, cell:UITableViewCell, indexPath:IndexPath) {
        let modelType = type(of: model).type
        let cellIdentifier = CellsIdentifiers.identifier(for: modelType)!
        let bindingFn = bindersMap[cellIdentifier]!
        bindingFn(model, cell, indexPath)
    }
}
