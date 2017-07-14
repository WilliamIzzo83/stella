//
//  ProductsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * This controllers shows the product list associated to a specific category.
 */
class ProductsListTableViewController : ItemsListTableViewController {
    /// Product's list category. This must be set before the data retrieve cycle
    /// begins.
    var department : DepartmentModel!
    
    override func setupListController() {
        dataProvider = BazDataProvider()
        binderDescriptorProvider = { _ in
            return ProductsListTableViewController.binderDescriptor
        }
        
        title = department.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailController = segue.destination as! ProductDetailViewController
        let selectedPath = tableView.indexPathForSelectedRow!
        let item = self.item(at: selectedPath)
        
        productDetailController.product = item as! FooModel
    }
}

/// Defines the binder descriptor for this controller
extension ProductsListTableViewController {
    fileprivate static let binderDescriptor =
        CellBinderDescriptor(cellReuseId:.productCell) { (cell, model) in
            let fooModel = model as! FooModel
            cell.textLabel?.text = fooModel.title
    }
}
