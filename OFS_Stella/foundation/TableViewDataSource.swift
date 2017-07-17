//
//  TableViewDataSource.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

protocol IDataSource {
    associatedtype T
    var items : [T] { get }
    var viewModelProvider : ((IndexPath, T) -> ViewModel)! { get }
    var cellIdProvider : ((IndexPath) -> String)! { get }
}

class TableViewDataSource<T> : NSObject, IDataSource, UITableViewDataSource {
    
    var items: [T] = []
    var viewModelProvider : ((IndexPath, T) -> ViewModel)!
    var cellIdProvider : ((IndexPath) -> String)!
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = cellIdProvider(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                 for: indexPath)
        let item = items[indexPath.row]
        let bindable = cell as! DataBindable
        let viewmodel = viewModelProvider(indexPath, item)
        
        bindable.bind(to: viewmodel)
        return cell
    }
}
