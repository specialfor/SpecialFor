//
//  CGSize+Extension.swift
//  Nynja
//
//  Created by Anton Makarov on 21.11.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import CoreGraphics

extension CGSize {
    
    public var imageResolution: String {
        return makeResolution(with: "x")
    }
    
    private func makeResolution(with separator: String) -> String {
        return "\(Int(width))" + separator + "\(Int(height))"
    }
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
