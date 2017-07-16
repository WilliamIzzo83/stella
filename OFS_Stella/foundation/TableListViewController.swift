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

struct BinderPayload<T> {
    weak var controller : TableListViewController<T>?
    let indexPath : IndexPath
}

class TableListViewController<DataType> :
UITableViewController, IListViewController {
    typealias ItemsType = DataType
    var privateItems_ : [ItemsType] = []
    var listView: IListView { return self.tableView }
    var dataProvider: GenericDataProvider<[ItemsType], Void>!
    var binderDescriptorProvider : ((ItemsType) -> ViewModelBinderDescriptor<ItemsType, BinderPayload<ItemsType>>)!
    var pendingTasks = [IndexPath:ITask]()
    
    var items: [ItemsType] {
        return privateItems_
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupListViewController()
        self.consumeData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        for (_, v) in pendingTasks {
            v.cancel()
        }
        
        pendingTasks.removeAll()
    }
    
    func setupListViewController() {}
    
    func handleError(error: Error) {}
    
    func updateItems(items: [ItemsType]) {
        privateItems_ = items
    }
    
    func enqueueTaskForItem(at indexPath: IndexPath, task: ITask) {
        if let previousTaskAtPath = pendingTasks[indexPath] {
            previousTaskAtPath.cancel()
        }
        
        pendingTasks[indexPath] = task
        guard let visiblePaths = tableView.indexPathsForVisibleRows else {
            return
        }
        
        guard visiblePaths.contains(indexPath) else {
            return
        }
        
        print("executes ON ENQUEUE - row \(indexPath.row)")
        task.execute()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateItems_.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let pathTask = pendingTasks[indexPath] else {
            return
        }
        print("executes ON APPEAR - row \(indexPath.row)")
        
        pathTask.execute()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let pathTask = pendingTasks[indexPath] else {
            return
        }
        
        print("cancels ON DISAPPEAR - row \(indexPath.row)")
        pathTask.cancel()
        pendingTasks[indexPath] = nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = privateItems_[indexPath.row]
        let binderDesc = binderDescriptorProvider(model)
        
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: binderDesc.cellReuseId.rawValue,
            for: indexPath)
        
        
        binderDesc.bind(cell, model, BinderPayload(controller: self,
                                                   indexPath: indexPath) )
        
        return cell
    }
}
