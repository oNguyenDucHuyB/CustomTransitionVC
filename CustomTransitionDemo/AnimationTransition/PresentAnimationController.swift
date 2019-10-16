//
//  PresentAnimationController.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 10/8/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? ViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? DetailViewController else {
                transitionContext.completeTransition(true)
                return
        }

        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)

        let textFieldSnapshot = fromViewController.textField1.snapshotView(afterScreenUpdates: false)
        textFieldSnapshot?.frame = containerView.convert(fromViewController.textField1.frame, from: fromViewController.view)
        fromViewController.textField1.isHidden = true
        
        toViewController.view.alpha = 0
        toViewController.textField2.isHidden = true

        containerView.addSubview(toViewController.view)
        containerView.addSubview(textFieldSnapshot!)

        UIView.animate(withDuration: duration, animations: { () -> Void in
            toViewController.view.layoutIfNeeded()
            toViewController.view.alpha = 1.0
            let endRect = containerView.convert(toViewController.textField2.frame, from: toViewController.view)
            textFieldSnapshot?.frame = endRect
        }) { _ in
            let success = !transitionContext.transitionWasCancelled
            toViewController.textField2.isHidden = false
            fromViewController.textField1.isHidden = false
            textFieldSnapshot?.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
    }
}
