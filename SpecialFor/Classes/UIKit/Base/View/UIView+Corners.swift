//
//  UIView+Corners.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/27/19.
//

import UIKit

extension UIView {
    
    public func roundCorners() {
        let radius = self.bounds.height / 2
        roundCorners(radius: radius)
    }
    
    public func roundCorners(radius: CGFloat) {
        _roundCorners(radius: radius)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        roundCorners(corners, radius: radius, withRect: self.bounds)
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat, withRect: CGRect) {
        let path = UIBezierPath(roundedRect: withRect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    private func _roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

extension Array where Element: UIView {
    
    public func roundCorners() {
        forEach { $0.roundCorners() }
    }
    
    public func roundCorners(radius: CGFloat) {
        forEach { $0.roundCorners(radius: radius) }
    }
}
