//
//  CategoriesTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * This is the main view controller of the application. It renders application's
 * main category list, allowing user to navigate them. The controller is a 
 * specialization of ItemsListTableViewController.
 */
class CategoriesTableViewController: ItemsListTableViewController {
    override func setupListController() {
        dataProvider = FooDataProvider()
        binderDescriptorProvider = { _ in
            return CategoriesTableViewController.binderDescriptor
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productListController = segue.destination as! ProductsListTableViewController
        let selectedPath = tableView.indexPathForSelectedRow!        
        let item = self.item(at: selectedPath)

        productListController.category = item as! FooModel
    }
}

/// This extension defines binder descriptor used by
/// CategoriesTableViewController
extension CategoriesTableViewController {
    fileprivate static let binderDescriptor =
        CellBinderDescriptor(cellReuseId:.categoryCell) { (cell, model) in
            let fooModel = model as! FooModel
            cell.textLabel?.text = fooModel.title
    }
}
