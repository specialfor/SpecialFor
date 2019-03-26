//
//  CGRect+Updating.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 24.07.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension CGRect {
    
    public func updating(x: CGFloat) -> CGRect {
        return CGRect(x: x, y: minY, width: width, height: height)
    }
    
    public func updating(y: CGFloat) -> CGRect {
        return CGRect(x: minX, y: y, width: width, height: height)
    }
    
    public func updating(width: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    public func updating(height: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}

