//
//  ProductsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class ProductsDataSource : TableViewDataSource<ProductModel> {
    override init() {
        super.init()
        cellIdProvider = { _ in
            return CellsIdentifiers.productCell.rawValue
        }
        
        viewModelProvider = {
            let viewModel = ProductCellProductViewModel(product: $1)
            return viewModel
        }
    }
}

/**
 * This controllers shows the product list associated to a specific category.
 */
class ProductsListTableViewController : GenericTableViewController<ProductModel> {
    
    /// Product's list category. This must be set before the data retrieve cycle
    /// begins.
    var department : DepartmentModel!
    
    override func setupController() {
        dataProvider = URLDataProvider<[ProductModel]>.productsDataProvider(department: department.id)
        dataSource = ProductsDataSource()
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

