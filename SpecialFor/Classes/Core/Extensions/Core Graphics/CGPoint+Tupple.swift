//
//  CGPoint+Tupple.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 3/10/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
    init(_ point: (x: CGFloat, y: CGFloat)) {
        self.init(x: point.x, y: point.y)
    }
}
