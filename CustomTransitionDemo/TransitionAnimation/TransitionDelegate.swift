//
//  TransitionDelegate.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 11/1/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimationController(presenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeAnimationController(presenting: false)
    }
}
