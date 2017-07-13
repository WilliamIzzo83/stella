//
//  ProductDetailViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 13/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product : FooModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = product.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
