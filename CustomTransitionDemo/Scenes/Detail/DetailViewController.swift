//
//  ViewController2.swift
//  CustomTransitionDemo
//
//  Created by nguyen.duc.huyb on 10/7/19.
//  Copyright © 2019 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var textField2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension DetailViewController: CustomTransitionDestination {
    var toAnimatedSubviews: [UIView] { return [textField2] }
}

extension DetailViewController: CustomTransitionOriginator {
    var fromAnimatedSubviews: [UIView] { return [textField2] }
}
