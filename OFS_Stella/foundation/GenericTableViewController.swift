//
//  GenericTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class GenericTableViewController<T>: UITableViewController {
    var dataProvider : GenericDataProvider<[T], Void>!
    var dataSource : TableViewDataSource<T>!
    
    func setupController() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        tableView.dataSource = dataSource
        
        _ =
        dataProvider
            .requestData(request: Void()) { [weak self] (items, error) in
                DispatchQueue.main.async {
                    self?.dataSource.items = items!
                    self?.tableView.reloadData()
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
