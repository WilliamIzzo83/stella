//
//  TableViewDataSource.swift
//  OFS_Stella
//
//  Created by William Izzo on 16/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class implements a generalization on top of UITableViewDataSource.
 * The intent is to provide some kind of interface that makes it easy to select
 * what cell needs to be shown into the table views and what binding strategy to
 * apply on cell display:
 * - it exposes a closure that returns the view model of the item that needs to be shown
 * - it exposes a closure that returns the item's cell reuse identifier.
 *
 * Also it implements tableView's cellForRowAtindexPath method by leveraging
 * those two closure and by finally bind the item data to the dequeued cell.
 */
class TableViewDataSource<T> : NSObject, UITableViewDataSource {
    /// Contains the items that will be rendered by the data source.
    var items: [T] = []
    /// A closure that returns a view model for a specific index path. This
    /// method gets called during data source's cellForRowAtIndexPath.
    /// - parameter path: index path of the item being rendered.
    /// - parameter item: being rendered. With this parameter the closure may
    /// decide to return a specific view model based on item's contents.
    var viewModelProvider : ((_ path:IndexPath, _ item:T) -> ViewModel)!
    /// A closure that returns a cell reuse identifier for a specific index
    /// path. This method gets called during data source's
    /// cellForRowAtIndexPath.
    /// - parameter path: index path of the item being rendered.
    var cellIdProvider : ((_ path:IndexPath) -> String)!
    
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
        let bindable = cell as! ViewModelBindable
        let viewmodel = viewModelProvider(indexPath, item)
        
        bindable.bind(to: viewmodel)
        return cell
    }
}
