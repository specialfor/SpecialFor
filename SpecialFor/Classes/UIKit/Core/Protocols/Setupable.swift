//
//  Setupable.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import UIKit

public protocol Setupable {
    var activatedViews: [UIView] { get }
    
    func baseSetup()
}

public extension Setupable {
    func baseSetup() {
        activatedViews.activate()
    }
}

extension UIView: Setupable {
    @objc public func baseSetup() {
        activatedViews.activate()
    }
    
    @objc public var activatedViews: [UIView] {
        return []
    }
}

extension UIViewController: Setupable {
    @objc public func baseSetup() {
        activatedViews.activate()
    }
    
    @objc public var activatedViews: [UIView] {
        return []
    }
}

extension Array where Element: UIView {
    public func activate() {}
}
