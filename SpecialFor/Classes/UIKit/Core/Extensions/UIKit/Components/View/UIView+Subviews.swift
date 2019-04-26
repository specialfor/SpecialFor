//
//  UIView+Subviews.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 12/10/18.
//  Copyright © 2018 Specialfor. All rights reserved.
//

import UIKit

public extension UIView {
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
