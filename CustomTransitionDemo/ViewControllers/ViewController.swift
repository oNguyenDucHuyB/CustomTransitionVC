//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by Ludvig Eriksson on 2018-01-22.
//  Copyright © 2018 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    let transitionDelegate = TransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = transitionDelegate
    }
    
    @IBAction func handleTapButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        vc.transitioningDelegate = transitionDelegate
        present(vc, animated: true)
    }
}
