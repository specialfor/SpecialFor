//
//  UIView+Hierarchy.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/24/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension UIView {
    
    func firstAncestor<T: UIView>(ofType type: T.Type) -> T? {
        var superview = self.superview
        
        while superview != nil {
            if let superview = superview as? T {
                return superview
            }
            
            superview = superview?.superview
        }
        
        return nil
    }
    
    func firstSubview<T: UIView>(ofType type: T.Type) -> T? {
        for subview in subviews {
            if let result = subview as? T {
                return result
            } else if let result = subview.firstSubview(ofType: type) {
                return result
            }
        }
        return nil
    }
}
