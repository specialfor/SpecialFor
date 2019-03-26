//
//  UIImageView+Rounded.swift
//  Nynja
//
//  Created by Bohdan Paliychuk on 7/3/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func roundImageView(borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.nynja.black) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
    }
    
    func roundCornersImage(borderWidth: CGFloat = 0, cornerRadius: CGFloat = 2, borderColor: UIColor = UIColor.nynja.black) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}


