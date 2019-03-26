//
//  UIView+Gradient.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/11/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

enum GradientDirection {
    case fromTop
    case fromBottom
}

fileprivate typealias Points = (start: CGPoint, end: CGPoint)

extension UIView {
    
    func drawLinearGradient(in context: CGContext?, colors: [CGColor], direction: GradientDirection) {
        let points = self.points(direction)
        let locations: [CGFloat] = [0.0, 1.0]
        
        context?.drawLinearGradient(with: colors, locations: locations, from: points.start, to: points.end)
    }
    
    fileprivate func points(_ direction: GradientDirection) -> Points {
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch direction {
        case .fromTop:
            startPoint = CGPoint(x: bounds.midX, y: 0)
            endPoint = CGPoint(x: bounds.midX, y: bounds.height)
        case .fromBottom:
            startPoint = CGPoint(x: bounds.midX, y: bounds.height)
            endPoint = CGPoint(x: bounds.midX, y: 0)
        }
        
        return (startPoint, endPoint)
    }
    
    func setGradientMask (firstInset: CGFloat, secondInset:CGFloat, vertical:Bool) {
        let layer = layerForGradient(firstInset: firstInset, secondInset: secondInset, vertical: vertical)
        
        let view = UIView(frame: CGRect(x:0, y:0, width:frame.width, height: frame.height))
        view.layer.addSublayer(layer)
        self.mask = view
    }

    private func layerForGradient (firstInset: CGFloat, secondInset:CGFloat, vertical:Bool) -> CALayer {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x:0, y:0, width:frame.width, height: frame.height)
        layer.colors = [UIColor.clear.cgColor,
                        UIColor.black.cgColor,
                        UIColor.black.cgColor,
                        UIColor.clear.cgColor]
        
        let fullMetric = vertical ? layer.frame.height : layer.frame.width
        let firstCoeff = firstInset / fullMetric
        let secondCoeff = 1 - secondInset / fullMetric
        
        layer.locations = [0.0, NSNumber(value: Float(firstCoeff)), NSNumber(value: Float(secondCoeff)), 1.0]
        
        if !vertical {
            layer.startPoint = CGPoint(x:0.0, y:0.5);
            layer.endPoint = CGPoint(x:1.0, y:0.5);
        }
        
        return layer
    }
}
