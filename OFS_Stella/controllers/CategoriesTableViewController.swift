//
//  CategoriesTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit



class CategoriesTableViewController: ItemsListTableViewController {
    
    private let descs : [Int:CellBinderDescriptor] = [
        FooModelType :
            CellBinderDescriptor(cellReuseId:"category_cell") { (cell, model) in
                let fooModel = model as! FooModel
                cell.textLabel?.text = fooModel.title
        }
    ]
    
    override func dataProvider() -> IDataProvider {
        return FooDataProvider()
    }
    
    override func cellBinderDescriptor(model: IDataModel) -> CellBinderDescriptor {
        return descs[type(of: model).type]!
    }
}
