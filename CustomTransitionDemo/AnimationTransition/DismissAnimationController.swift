//
//  DismissAnimationController.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 10/7/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? DetailViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? ViewController else {
                transitionContext.completeTransition(true)
                return
        }

        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        let textFieldSnapshot = fromViewController.textField2.snapshotView(afterScreenUpdates: false)
        textFieldSnapshot?.frame = containerView.convert(fromViewController.textField2.frame, from: fromViewController.view)
        fromViewController.textField2.isHidden = true
        
        toViewController.view.alpha = 0
        toViewController.textField1.isHidden = true

        containerView.addSubview(toViewController.view)
        containerView.addSubview(textFieldSnapshot!)

        UIView.animate(withDuration: duration, animations: { () -> Void in
            toViewController.view.layoutIfNeeded()
            toViewController.view.alpha = 1.0
            let endRect = containerView.convert(toViewController.textField1.frame, from: toViewController.view)
            textFieldSnapshot?.frame = endRect
        }) { _ in
            let success = !transitionContext.transitionWasCancelled
            toViewController.textField1.isHidden = false
            fromViewController.textField2.isHidden = false
            textFieldSnapshot?.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
    }
}
