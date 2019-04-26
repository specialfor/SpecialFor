//
//  UIViewController+Child.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 3/4/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import UIKit

public extension UIViewController {
    func addChild(_ childController: UIViewController, closure: ClosureWith<UIView>) {
        addChild(childController)
        closure(childController.view)
        childController.didMove(toParent: self)
    }
    
    func removeChild(_ childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
}
