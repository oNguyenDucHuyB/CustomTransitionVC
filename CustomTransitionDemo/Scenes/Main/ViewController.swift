//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by Ludvig Eriksson on 2018-01-22.
//  Copyright © 2018 Ludvig Eriksson. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleTapButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
