//
//  CGContext+Gradient.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/11/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import CoreGraphics

extension CGContext {
    
    func drawLinearGradient(with colors: [CGColor], locations: [CGFloat], from: CGPoint, to: CGPoint) {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        drawLinearGradient(with: colors, locations: locations, from: from, to: to, colorSpace: colorSpace)
    }
    
    func drawLinearGradient(with colors: [CGColor], locations: [CGFloat], from: CGPoint, to: CGPoint, colorSpace: CGColorSpace, options: CGGradientDrawingOptions = []) {
        
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations) else {
            
            assertionFailure("Something gone wrong. Check arguments.")
            return
        }
        
        self.drawLinearGradient(gradient, start: from, end: to, options: options)
    }
    
}
