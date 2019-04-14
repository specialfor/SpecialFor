//
//  Backable.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/5/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

public protocol Backable {
    var backBarButtonItemImage: UIImage { get }
    var backBarButtonItem: UIBarButtonItem { get }
    
    func back()
}

extension UIViewController: Backable {
    @objc public var backBarButtonItemImage: UIImage {
        return #imageLiteral(resourceName: "ic_back")
    }
    
    @objc public var backBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(
            image: backBarButtonItemImage,
            style: .plain,
            target: self,
            action: #selector(back))
    }
    
    @objc public func back() {}
}
