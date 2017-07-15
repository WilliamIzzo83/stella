//
//  TableListViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView : IListView {}

class TableListViewController<DataType> :
UITableViewController, IListViewController {
    typealias ItemsType = DataType
    var privateItems_ : [ItemsType] = []
    var listView: IListView { return self.tableView }
    var dataProvider: GenericDataProvider<[ItemsType]>!
    var binderDescriptorProvider : ((ItemsType) -> ViewModelBinderDescriptor<ItemsType>)!
    
    var items: [ItemsType] {
        return privateItems_
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupListViewController()
        self.consumeData()
    }
    
    func setupListViewController() {}
    
    func handleError(error: Error) {}
    
    func updateItems(items: [ItemsType]) {
        privateItems_ = items
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateItems_.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = privateItems_[indexPath.row]
        let binderDesc = binderDescriptorProvider(model)
        
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: binderDesc.cellReuseId.rawValue,
            for: indexPath)
        
        
        binderDesc.bind(cell, model)
        
        return cell
    }
}
