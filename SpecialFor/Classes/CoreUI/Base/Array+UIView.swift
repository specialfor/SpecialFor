//
//  Array+Activate.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//

extension Array where Element: UIView {

    public func activate() {}
    
    public func removeFromSuperview() {
        self.forEach { $0.removeFromSuperview() }
    }
}
