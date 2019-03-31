//
//  UIImageView+Corners.swift
//  Nynja
//
//  Created by Bohdan Paliychuk on 7/3/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func roundCorners(borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.black) {
        let cornerRadius = frame.height / 2
        roundCorners(borderWidth: borderWidth, cornerRadius: cornerRadius, borderColor: borderColor)
    }
    
    func roundCorners(borderWidth: CGFloat = 0, cornerRadius: CGFloat = 2, borderColor: UIColor = UIColor.black) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}


