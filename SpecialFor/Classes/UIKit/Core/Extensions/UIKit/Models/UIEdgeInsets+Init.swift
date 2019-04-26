//
//  UIEdgeInsets+Init.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 12/23/18.
//  Copyright © 2018 Specialfor. All rights reserved.
//

import UIKit.UIGeometry

public extension UIEdgeInsets {
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
}
