//
//  UIFontExtension.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 12/27/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIFont {
    private struct FontInitialValues: Hashable {
        let fontName: String
        let height: CGFloat
        let width: CGFloat
    }
    
    private static var fontsCache: [FontInitialValues: UIFont] = [:]
    
    static func makeFont(with fontName: String, width: CGFloat = 100, height: CGFloat) -> UIFont? {
        let values = FontInitialValues(fontName: fontName, height: height, width: width)
        
        if let font = UIFont.fontsCache[values] {
            return font
        } else {
            let font = UIFont(fontName: fontName, width: width, height: height)
            
            if let font = font {
                UIFont.fontsCache[values] = font
            }
            
            return font
        }
    }
}

private extension UIFont {
    convenience init?(fontName: String, width: CGFloat = 100, height: CGFloat) {
        let size = "A".getFontSize(fontName: fontName, width: width, height: height)
        self.init(name: fontName, size: size)
    }
}

