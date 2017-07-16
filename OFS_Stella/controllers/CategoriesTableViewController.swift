//
//  CategoriesTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class DepartmentsDataSource : TableViewDataSource<DepartmentModel> {
    override init() {
        super.init()
        cellIdProvider = { _ in
            return CellsIdentifiers.categoryCell.rawValue
        }
        
        viewModelProvider = {
            let viewModel = DepartmentCategoryCellViewModel(department:$1)
            return viewModel
        }
    }
}

/**
 * This is the main view controller of the application. It renders application's
 * main category list, allowing user to navigate them. The controller is a 
 * specialization of ItemsListTableViewController.
 */
class CategoriesTableViewController: GenericTableViewController<DepartmentModel> {
    override func setupController() {
        dataProvider = DepartmentDataProvider()
        dataSource = DepartmentsDataSource()
        self.navigationItem.backBarButtonItem?.title = " "
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productListController = segue.destination as! ProductsListTableViewController
        let selectedPath = tableView.indexPathForSelectedRow!        
        let item = self.dataSource.items[selectedPath.row]
        
        productListController.department = item
    }
}


