//
//  ProductDetailViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

/**
 * A view controller that displays a product detail screen
 */
class ProductDetailViewController: UIViewController {
    /// Displayed product
    var product : ProductModel!
    /// View displaying the product.
    @IBOutlet var detailView : DetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.bind(to: DetailViewProductViewModel(product: product))
    }
}
