//
//  ViewControllerWith.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2018 Specialfor. All rights reserved.
//

import UIKit
import SnapKit

public class ViewControllerWith<T: UIView>: ViewController {
    public var rootView: T {
        return view as! T
    }
    
    public override func loadView() {
        view = T()
        rootView.backgroundColor = .white
    }
}
