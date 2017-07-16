//
//  ProductDetailViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product : ProductModel!
    @IBOutlet var detailView : DetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.bind(to: DetailViewProductViewModel(product: product))
    }
}
