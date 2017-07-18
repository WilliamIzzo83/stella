//
//  ConnectivityNotReachableViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 18/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit
import ReachabilitySwift
let reachability = Reachability()!

class ConnectivityNotReachableViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageLabel.text = AppStrings.notReachable.get()
        reachability.whenReachable = { [weak self] reachability in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "reachability_restored",
                                   sender:nil)
            }
        }
        try! reachability.startNotifier()
    }

}
