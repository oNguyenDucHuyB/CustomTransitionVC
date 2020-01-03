//
//  UIView+.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 1/3/20.
//  Copyright © 2020 Ludvig Eriksson. All rights reserved.
//

import UIKit

extension UIView {
    func zo_snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        if let context = context {
            layer.render(in: context)
        }
        let snapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snapshot
    }
    
    func snapshotView() -> UIView? {
        if let snapshotImage = zo_snapshot() {
            return UIImageView(image: snapshotImage)
        } else {
            return nil
        }
    }
}
