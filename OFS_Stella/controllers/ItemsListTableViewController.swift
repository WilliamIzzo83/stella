//
//  ItemsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit


struct CellBinderDescriptor {
    let cellReuseId : String
    let bind : (UITableViewCell, IDataModel) -> Void
}


class ItemsListTableViewController: UITableViewController, IDataConsumer {
    
    var itemsList = [IDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.consumeData()
    }
    
    func cellBinderDescriptor(model:IDataModel) -> CellBinderDescriptor {
        return CellBinderDescriptor(cellReuseId: "") { (cell) in }
    }
    
    func dataProvider() -> IDataProvider {
        return NullDataProvider()
    }
    
    func consumeData() {
        dataProvider().retrieveData { [weak self](data, error) in
            guard error == nil else {
                return
            }
            
            guard let wself = self else {
                return
            }
            
            wself.itemsList = data
            wself.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = itemsList[indexPath.row]
        
        let binderDesc = cellBinderDescriptor(model: model)
        
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: binderDesc.cellReuseId,
            for: indexPath)
        
        
        binderDesc.bind(cell, model)
        
        return cell
    }

}
