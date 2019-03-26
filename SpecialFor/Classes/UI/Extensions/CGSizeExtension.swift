//
//  CGFloatExtension.swift
//  Nynja
//
//  Created by Anton Makarov on 21.11.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import AVFoundation

extension CGSize {
    
    func heightForWidth(width: CGFloat) -> CGFloat {
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: width,
                                  height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: self,
                               insideRect: boundingRect)
        return rect.size.height
    }
    
    func widthForHeight(height: CGFloat) -> CGFloat {
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: CGFloat(MAXFLOAT),
                                  height: height)
        let rect  = AVMakeRect(aspectRatio: self,
                               insideRect: boundingRect)
        return rect.size.width
    }
    
    var resolutionString: String {
        return makeResolution(with: ":")
    }
    
    var imageResolution: String {
        return makeResolution(with: "x")
    }
    
    private func makeResolution(with separator: String) -> String {
        return "\(Int(width))" + separator + "\(Int(height))"
    }
}

func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}
