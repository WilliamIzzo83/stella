//
//  IListController.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation

protocol IListView {
    func reloadData()
}

protocol IListViewController : class {
    associatedtype ItemsType
    var items : [ItemsType] { get }
    var listView : IListView { get }
    var dataProvider : GenericDataProvider<[ItemsType], Void>! { get set }
    
    func setupListViewController()
    func item(at indexPath:IndexPath) -> ItemsType
    func updateItems(items:[ItemsType])
    func handleError(error:Error)
    func enqueueTaskForItem(at: IndexPath, task:ITask)
    
    func consumeData()
}

extension IListViewController {
    func item(at path:IndexPath) -> ItemsType {
        return items[path.row]
    }
    
    func consumeData() {
        _ =
            dataProvider.retrieveData(request: Void() ) { [weak self] in
            guard let wself = self else {
                return
            }
            
            guard $1 == nil else {
                wself.handleError(error: $1!)
                return
            }
            
            guard let items = $0 else {
                return
            }
            
            DispatchQueue.main.async {
                wself.updateItems(items: items)
                wself.listView.reloadData()
            }
        }
    }
}


