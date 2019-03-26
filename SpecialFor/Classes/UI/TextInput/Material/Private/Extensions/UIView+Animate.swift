//
//  UIView+Animate.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/19/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

fileprivate let duration: TimeInterval = 0.3

extension UIView {

    func animate(with duration: TimeInterval = duration, animations: @escaping () -> Void) {
        animate(with: duration, animations: animations, completion: nil)
    }
    
    func animate(with duration: TimeInterval = duration, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.layoutIfNeeded()
        UIView.animate(withDuration: duration, animations: {
            animations()
            self.layoutIfNeeded()
        }) { (isFinished) in
            completion?(isFinished)
        }
    }
    
}
