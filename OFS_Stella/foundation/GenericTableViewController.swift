//
//  GenericTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * A generic table view controller implementation. Subclasses may define its
 * behavior by assigning *dataProvider* and dataSource properties
 * - SeeAlso: `GenericDataProvider<T,U>`
 * - SeeAlso: `TableViewDataSource<T>`
 */
class GenericTableViewController<T>: UITableViewController {
    /// Provider used to retrieve table view controller's data
    var dataProvider : GenericDataProvider<[T], Void>!
    
    /// Data source in charge of display the data.
    var dataSource : TableViewDataSource<T>!
    
    /// Function called during *viewDidLoad()*. This allows subclasses to
    /// configure the controller's dataProvider and dataSource.
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
