//
//  CollectionListViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 15/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView : IListView {}

class CollectionListViewController<T> : UICollectionViewController, IListViewController {
    
    
    typealias ItemsType = T
    
    var privateItems_ : [ItemsType] = []
    var listView: IListView { return self.collectionView! }
    var dataProvider: GenericDataProvider<[ItemsType],Void>!
    var binderDescriptorProvider : ((ItemsType) -> ViewModelBinderDescriptor<ItemsType, UICollectionView>)!
    
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
    
    func enqueueTaskForItem(at: IndexPath, task: ITask) {}
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return privateItems_.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = privateItems_[indexPath.row]
        let binderDesc = binderDescriptorProvider(model)
        
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: binderDesc.cellReuseId.rawValue,
            for: indexPath)
        
        
        binderDesc.bind(cell, model, collectionView)
        
        return cell
    }
}
