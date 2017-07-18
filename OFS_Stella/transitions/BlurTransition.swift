//
//  BlurTransition.swift
//  OFS_Stella
//
//  Created by William Izzo on 18/07/2017.
//  Copyright © 2017 wizzo. All rights reserved.
//

import Foundation
import UIKit

/**
 * This class handles animation's transition. It will take a snapshot of the
 * source view controller's view , adds a blur layer and then puts
 * destination view controller's view on top of it.
 */
class BlurTransition : NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    private var isPresenting = false
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        if(isPresenting) {
            presentTransition(containerView: containerView,
                              fromController: fromViewController,
                              toController: toViewController,
                              transitionContext: transitionContext)
        } else {
            dismissTransition(containerView: containerView,
                              fromController: fromViewController,
                              toController: toViewController,
                              transitionContext: transitionContext)
        }
    }
    
    func presentTransition(containerView:UIView, fromController:UIViewController, toController:UIViewController, transitionContext:UIViewControllerContextTransitioning) {
        
        let blurredView = fromController.view!
        
        UIGraphicsBeginImageContextWithOptions(
            containerView.bounds.size,
            false,
            UIScreen.main.scale)
        
        blurredView.drawHierarchy(in: blurredView.bounds,
                                  afterScreenUpdates: true)
        
        
        
        
        let blurredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let blurredImageView = UIImageView(frame: containerView.bounds)
        let blurFx = UIBlurEffect(style:.light)
        let blurView = UIVisualEffectView(effect: blurFx)
        let targetView = toController.view!
        
        blurredImageView.image = blurredImage
        
        blurredImageView.tag = 42
        blurView.tag = 32
        containerView.addSubview(blurredImageView)
        containerView.addSubview(blurView)
        containerView.addSubview(targetView)
        
        blurView.frame = containerView.bounds
        blurView.alpha = 0.0
        targetView.alpha = 0.0
        
        targetView.backgroundColor = UIColor.clear
        
        let animTime = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animTime,
                       animations: {
                        blurredImageView.alpha = 1.0
                        blurView.alpha = 1.0
                        targetView.alpha = 1.0
        }) { [weak self] _ in
            self?.finish(transitionContext: transitionContext)
        }
    }
    
    func dismissTransition(containerView:UIView, fromController:UIViewController, toController:UIViewController, transitionContext:UIViewControllerContextTransitioning) {
        
        let bgImage = containerView.viewWithTag(42)
        let blurView = containerView.viewWithTag(32)
        let animTime = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animTime,
                       animations: {
                        fromController.view.alpha = 0.0
                        blurView?.alpha = 0.0
                        bgImage?.alpha = 0.0
        }) { [weak self] _ in
            bgImage?.removeFromSuperview()
            fromController.view.removeFromSuperview()
            blurView?.removeFromSuperview()
            self?.finish(transitionContext: transitionContext)
        }
    }
    
    func finish(transitionContext:UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
