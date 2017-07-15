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
class ProductsListTableViewController : TableListViewController<ProductModel> {
    /// Product's list category. This must be set before the data retrieve cycle
    /// begins.
    var department : DepartmentModel!
    
    override func setupListViewController() {
        let provider = URLDataProvider<[ProductModel]>.productsDataProvider(department: department.id)
        dataProvider = provider
        binderDescriptorProvider = { _ in
            return ProductsListTableViewController.binderDescriptor
        }
        
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
        title = department.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailController = segue.destination as! ProductDetailViewController
        let selectedPath = tableView.indexPathForSelectedRow!
        let item = self.item(at: selectedPath)
        
        productDetailController.product = item
    }
}

/// Defines the binder descriptor for this controller
extension ProductsListTableViewController {
    fileprivate static let binderDescriptor =
        ViewModelBinderDescriptor<ProductModel>(cellReuseId:.productCell) { (cell, model) in
            let productCell = cell as! ProductTableViewCell
            productCell.nameLabel.text = model.modelNames
            productCell.priceLabel.text = "\(model.fullPrice)"
            
            
    }
}
