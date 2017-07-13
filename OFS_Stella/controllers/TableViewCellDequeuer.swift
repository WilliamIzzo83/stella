//
//  TableViewCellDequeuer.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * Declares dequeuable cell identifiers
 */
enum CellsIdentifiers : String {
    case categoryCell = "category_cell"
    case productCell = "product_cell"
}

extension CellsIdentifiers {
    static func identifier(for modelType:Int) -> CellsIdentifiers? {
        switch modelType {
        case FooModelType:
            return .categoryCell
        default:
            return nil
        }
    }
}

func dequeueTableViewCell(tableView:UITableView,
                          indexPath:IndexPath,
                          modelType: Int) -> UITableViewCell{
    
    // Optional unwrapping is enforced so that unknown identifiers get caught
    // during development
    let cellIdentifier = CellsIdentifiers.identifier(for: modelType)!.rawValue
    
    return tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier,
        for: indexPath)
}
