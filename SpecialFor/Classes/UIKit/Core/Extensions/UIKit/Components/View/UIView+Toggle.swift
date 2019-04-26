//
//  UIView+Toggle.swift
//  Nynja
//
//  Created by Anton Makarov on 28.08.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIView {
    func toggleIfNeeded(_ shouldShow: Bool, closure: (() -> Void)? = nil) {
        let isShown = !self.isHidden
        
        guard isShown != shouldShow else {
            return
        }
        
        self.isHidden = !shouldShow
        
        closure?()
    }
}
