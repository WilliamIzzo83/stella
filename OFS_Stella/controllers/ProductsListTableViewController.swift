//
//  ProductsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class ProductsListTableViewController : ItemsListTableViewController {
    var category : FooModel!
    
    override func viewDidLoad() {
        dataProvider = BazDataProvider()
        super.viewDidLoad()
        title = category.title
    }
    
    private let binderDescriptor =
        CellBinderDescriptor(cellReuseId:.productCell) { (cell, model) in
            let fooModel = model as! FooModel
            cell.textLabel?.text = fooModel.title
    }
    
    override func cellBinderDescriptor(model: IDataModel) -> CellBinderDescriptor {
        return binderDescriptor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailController = segue.destination as! ProductDetailViewController
        let selectedPath = tableView.indexPathForSelectedRow!
        let item = self.item(at: selectedPath)
        
        productDetailController.product = item as! FooModel
    }
}
