//
//  UIView+Shadow.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 2/19/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIView {
    
    func adjustShadow(with radius: CGFloat, color: UIColor = UIColor.nynja.black) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = radius
    }
}
