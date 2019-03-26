//
//  UIScreen+Keyboard.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 24.06.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIScreen {
    
    var defaultKeyboardHeight: CGFloat {
        let height = bounds.height
        if height >= 812 {
            return 333
        } else if height >= 736 {
            return 271
        } else if height >= 667 {
            return 258
        } else {
            return 253
        }
    }
    
    var defaultKeyboardSize: CGSize {
        return CGSize(width: bounds.width, height: defaultKeyboardHeight)
    }
}
