//
//  UIWinfow+SafeArea.swift
//  SpecialFor
//
//  Created by Volodymyr Hryhoriev on 3/30/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

public extension UIWindow {
    static var topInset: CGFloat {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets.top ?? 0
        } else {
            return 0
        }
    }
    
    static var bottomInset: CGFloat {
        let window = UIApplication.shared.keyWindow
        if #available(iOS 11.0, *) {
            return window?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
}
