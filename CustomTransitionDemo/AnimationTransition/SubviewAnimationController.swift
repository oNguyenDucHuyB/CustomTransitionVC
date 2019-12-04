//
//  SubviewAnimationController.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 12/3/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

protocol CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] { get }
}

protocol CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] { get }
}

class SubviewAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionType {
        case present
        case dismiss
    }
    
    let type: TransitionType
    
    init(type: TransitionType) {
        self.type = type
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from) as! CustomTransitionOriginator & UIViewController
        let toVC = transitionContext.viewController(forKey: .to) as! CustomTransitionDestination & UIViewController
        
        let container = transitionContext.containerView
        
        // add the "to" view to the hierarchy
        
        if type == .present {
            container.addSubview(toVC.view)
        } else {
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
        }
        toVC.view.layoutIfNeeded()
        
        // Create snapshots of label being animated
        
        let fromSnapshots = fromVC.fromAnimatedSubviews.map { subview -> UIView in
            // Create snapshot
            
            let snapshot = subview.snapshotView(afterScreenUpdates: false)!
            
            // We're putting it in container, so convert original frame into container's coordinate space
            
            snapshot.frame = container.convert(subview.frame, from: subview.superview)
            
            return snapshot
        }
        
        let toSnapshots = toVC.toAnimatedSubviews.map { subview -> UIView in
            // Create snapshot
            
            let snapshot = subview.snapshotView(afterScreenUpdates: true)! // UIImageView(image: subview.snapshot())
            
            // we're putting it in container, so convert original frame into container's coordinate space
            
            snapshot.frame = container.convert(subview.frame, from: subview.superview)
            
            return snapshot
        }
        
        // save the "to" and "from" frames
        
        let frames = zip(fromSnapshots, toSnapshots).map { ($0.frame, $1.frame) }
        
        // add "from" snapshots, too, but hide the subviews that we just snapshotted
        // associated textfield so we only see animated snapshots; we'll unhide these
        // original views when the animation is done.
        
        fromSnapshots.forEach { container.addSubview($0) }
        fromVC.fromAnimatedSubviews.forEach { $0.alpha = 0 }
        toVC.toAnimatedSubviews.forEach { $0.alpha = 0 }
        
        // I'm going to push the the main view from the right and dim the "from" view a bit,
        // but you'll obviously do whatever you want for the main view, if anything

        if type == .present {
            toVC.view.transform = .init(translationX: toVC.view.frame.width, y: 0)
        } else {
            toVC.view.alpha = 0.5
        }
        
        // do the animation
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // animate the snapshots of the textfield
            
            zip(fromSnapshots, frames).forEach { snapshot, frame in
                snapshot.frame = frame.1
                snapshot.alpha = 1
            }
            
            // I'm now animating the "to" view into place, but you'd do whatever you want here

            if self.type == .present {
                toVC.view.transform = .identity
                fromVC.view.alpha = 0.5
            } else {
                fromVC.view.transform = .init(translationX: fromVC.view.frame.width, y: 0)
                toVC.view.alpha = 1
            }
        }, completion: { _ in
            // get rid of snapshots and re-show the original labels
            
            fromSnapshots.forEach { $0.removeFromSuperview() }
            
            fromVC.fromAnimatedSubviews.forEach { $0.alpha = 1 }
            toVC.toAnimatedSubviews.forEach { $0.alpha = 1 }
            
            // clean up "to" and "from" views as necessary, in my case, just restore "from" view's alpha

            fromVC.view.alpha = 1
            fromVC.view.transform = .identity

            // complete the transition
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
