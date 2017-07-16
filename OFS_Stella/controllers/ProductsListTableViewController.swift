//
//  ProductsListTableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * This controllers shows the product list associated to a specific category.
 */
class ProductsListTableViewController : TableListViewController<ProductModel> {
    /// Product's list category. This must be set before the data retrieve cycle
    /// begins.
    var department : DepartmentModel!
    var imagesProvider = ProductImagesProvider()
    
    override func setupListViewController() {
        let provider = URLDataProvider<[ProductModel]>.productsDataProvider(department: department.id)
        dataProvider = provider
        binderDescriptorProvider = { _ in
            return self.descriptor()
        }
        
        tableView.estimatedRowHeight = 88.0
        tableView.rowHeight = UITableViewAutomaticDimension
        title = department.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailController = segue.destination as! ProductDetailViewController
        let selectedPath = tableView.indexPathForSelectedRow!
        let item = self.item(at: selectedPath)
        
        productDetailController.product = item
        
    }
    
    deinit {
        print("deiniting")
    }
}

class LoadCellRemoteImageTask : ITask {
    let imagesProvider : ProductImagesProvider
    let request : ImageRequest
    let taskComplete : (UIImage?, Error?) -> Void
    private var taskToken : DataProviderToken?
    
    init(imagesProvider:ProductImagesProvider,
         request: ImageRequest,
         onTaskComplete:@escaping (UIImage?, Error?)->Void) {
        self.imagesProvider = imagesProvider
        self.request = request
        self.taskComplete = onTaskComplete
    }
    
    func execute() {
        
        taskToken = imagesProvider.retrieveData(request: request,
                                                didRetrieveDataCallback: taskComplete)
    }
    
    func cancel() {
        guard let token = self.taskToken else {
            return
        }
        
        imagesProvider.cancelRequest(token: token)
    }
}

/// Defines the binder descriptor for this controller
extension ProductsListTableViewController {
    fileprivate typealias BinderDescriptorType = ViewModelBinderDescriptor<ProductModel, BinderPayload<ProductModel>>
    
    fileprivate func descriptor() -> BinderDescriptorType {
        let imagesProvider = self.imagesProvider
        return
            BinderDescriptorType(cellReuseId:.productCell) { (cell, model, payload) in
                let productCell = cell as! ProductTableViewCell
                
                productCell.nameLabel.text = model.modelNames
                productCell.priceLabel.text = "\(model.fullPrice)"
                
                guard let controller = payload.controller else {
                    return
                }
                
                let tableView = controller.listView as! UITableView
                
                
                let loadImageTask = LoadCellRemoteImageTask(
                    imagesProvider: imagesProvider,
                    request: .thumb(model.defaultCode10),
                    onTaskComplete: {
                        guard $1 == nil else {
                            return
                        }
                        
                        guard let image = $0 else {
                            return
                        }
                        DispatchQueue.main.async {
                            guard let cellPath = tableView.indexPath(for: productCell) else {
                                return
                            }
                            
                            if productCell == tableView.cellForRow(at: cellPath) {
                                productCell.thumbnailImageView.image = image
                            } else {
                                print("skip")
                            }
                        }
                })
                
                controller.enqueueTaskForItem(at:payload.indexPath, task:loadImageTask)
        }
    }
}
