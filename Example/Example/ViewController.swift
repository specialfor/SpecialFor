//
//  ViewController.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SpecialFor

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientView = GradientView(colors: [.red, .black])
        gradientView.frame.size = CGSize(width: 100, height: 100)
        view.addSubview(gradientView)
    }
}
