//
//  ItemsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * ItemsListTableViewController provides a base class to manage application's
 * table view controllers. The class adopts IDataConsumer protocol, so that
 * when controller's view gets loaded it can get and render needed data.
 *
 * On *viewDidLoad* the controller performs the following operation:
 * - it calls *setupListController* method. This is done to give a chance to 
 * subclasses to customize controller's behaviors (i.e like setting the data
 * provider)
 * - it calls *consumeData* implementation. This method will invoke data 
 * provider's *retrieveData* method
 * - provided data get stored into an inner item's list array
 * - Controller's underlying UITableView gets reloaded.
 *
 * The class interface allows for table view's cell rendering and data binding
 * customization. To do so a subclass must assign *binderDescritorProvider* a
 * function that given a model returns a CellBinderDescriptor. By doing so
 * during table view's *cellForRowAtIndexPath* method the following happens:
 *
 * - A data model is extracted from the inner item's list (filled by data 
 * provider invocation)
 * - The function assigned to *binderDescriptorProvider* gets invoked.
 * - A cell reuse identifier is extracted from CellBinderDescriptor.
 * - A tableViewCell gets dequeued with the identifier extracted.
 * - CellBinderDescriptor's bind function is invoked by passing in the dequeued
 * cell and the data model.
 *
 * It is to be noted that this works as an abstract class, thus an instance of
 * ItemsListTableViewController will be missing its *dataProvider* and its
 * *binderDescriptorProvider*, resulting in a runtime crash.
 */
class ItemsListTableViewController<T>: UITableViewController {
    
    
    /// The item's list extracted by data provider.
    private var itemsList = [T]()
    
    /// A data provider that gets invoked on *viewDidLoad*.
    var dataProvider : GenericDataProvider<[T]>!
    
    /// Function invoked during *cellForRowAtIndexPath*. This will return a 
    /// binder descriptor used to customize cell's rendering and data binding.
    var binderDescriptorProvider : ((T) -> ViewModelBinderDescriptor<T>)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.setupListController()
        self.consumeData()
    }
    
    /// This function gets called before data consumption. Subclasses can 
    /// override this method to get a chance to assign the data provider and
    /// the binder descriptor provider.
    func setupListController() {}
    
    /// Returns an item from item's list
    func item(at path:IndexPath) -> T {
        return itemsList[path.row]
    }
    
    /// Calls data provider's *retrieveData* method. At the end of it itemsList
    /// array gets filled and the underlying table view *reloadData* method is
    /// invoked.
    func consumeData() {
        
        dataProvider.retrieveData { [weak self](data, error) in
            guard error == nil else {
                return
            }
            
            guard let wself = self else {
                return
            }
            
            DispatchQueue.main.async {
                wself.itemsList = data ?? []
                wself.tableView.reloadData()
            }
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
        let binderDesc = binderDescriptorProvider(model)
        
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: binderDesc.cellReuseId.rawValue,
            for: indexPath)
        
        
        binderDesc.bind(cell, model)
        
        return cell
    }

}
