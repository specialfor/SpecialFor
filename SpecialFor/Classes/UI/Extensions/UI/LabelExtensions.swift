//
//  LabelExtensions.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/19/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// Create label which fit rect with size.
    /// Also set 'lineBreakMode' to '.byTruncatingTail'.
    /// Default value for 'textAlignment' parameter is '.left'
    convenience init(size: CGSize, color: UIColor, fontName: String, textAlignment: NSTextAlignment = .left) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: size))
        
        self.font = UIFont.makeFont(with: fontName, width: size.width, height: size.height)
        self.textColor = color
        self.textAlignment = textAlignment
        self.lineBreakMode = .byTruncatingTail
    }
    
    convenience init(height: CGFloat, color: UIColor, fontName: String, textAlignment: NSTextAlignment = .left) {
        self.init(size: CGSize(width: 100, height: height), color: color, fontName: fontName, textAlignment: textAlignment)
    }
    
}
