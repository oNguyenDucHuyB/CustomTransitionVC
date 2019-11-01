//
//  ViewController2.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 11/1/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class ViewController2: UIViewController {

    var transitionDelegate: UIViewControllerTransitioningDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = transitioningDelegate
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
