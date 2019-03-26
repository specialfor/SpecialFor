//
//  UIViewExtenstions.swift
//  Nynja
//
//  Created by Anton Makarov on 28.08.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIView {
    
    static func roundCorners(for views: [UIView]) {
        views.forEach { $0.roundCorners() }
    }
    
    static func roundCorners(for views: [UIView], radius: CGFloat) {
        views.forEach { $0.roundCorners(radius: radius) }
    }
    
    func roundCorners() {
        let radius = self.bounds.height / 2
        roundCorners(radius: radius)
    }
    
    func roundCorners(radius: CGFloat) {
        _roundCorners(radius: radius)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        roundCorners(corners, radius: radius, withRect: self.bounds)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, withRect: CGRect) {
        let path = UIBezierPath(roundedRect: withRect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func endEditingDeep() {
        endEditing(true)
        subviews.forEach({ $0.endEditingDeep() })
    }
    
    private func _roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func toggleIfNeeded(_ shouldShow: Bool, closure: (() -> Void)? = nil) {
        let isShown = !self.isHidden
        
        guard isShown != shouldShow else {
            return
        }
        
        self.isHidden = !shouldShow
        
        closure?()
    }

    func recursiveListOfSubviews() -> [UIView] {
        var list: [UIView] = []

        list.append(contentsOf: subviews)

        for subview in subviews {
            list.append(contentsOf: subview.recursiveListOfSubviews())
        }

        return list
    }
}
