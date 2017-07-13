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
    
    private let binderDescriptor =
        CellBinderDescriptor(cellReuseId:.categoryCell) { (cell, model) in
        let fooModel = model as! FooModel
        cell.textLabel?.text = fooModel.title
    }
    
    override func viewDidLoad() {
        dataProvider = FooDataProvider()
        super.viewDidLoad()
    }
    
    override func cellBinderDescriptor(model: IDataModel) -> CellBinderDescriptor {
        return binderDescriptor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productListController = segue.destination as! ProductsListTableViewController
        let selectedPath = tableView.indexPathForSelectedRow!        
        let item = self.item(at: selectedPath)

        productListController.category = item as! FooModel
    }
}
