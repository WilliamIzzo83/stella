//
//  AppNavigationViewController.swift
//  OFS_Stella
//
//  Created by William Izzo on 18/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import UIKit
import ReachabilitySwift
class AppNavigationViewController: UINavigationController {
    let reachability = Reachability()!
    let blurTransition = BlurTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        reachability.whenUnreachable = { [weak self] reachability in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "reachability_gone", sender: nil)
            }
        }
        
        try! reachability.startNotifier()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "reachability_gone" else {
            return
        }
        
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = blurTransition
    }
    
    @IBAction func handleReachability(segue:UIStoryboardSegue) {
        
    }

}
