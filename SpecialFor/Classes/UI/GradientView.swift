//
//  GradientView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/18/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var colors: [UIColor] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Init
    init(colors: [UIColor]) {
        self.colors = colors
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Draw
    override func draw(_ rect: CGRect) {
        if !colors.isEmpty {
            let context = UIGraphicsGetCurrentContext()
            let cgColors = colors.map { $0.cgColor }
            drawLinearGradient(in: context, colors: cgColors, direction: .fromTop)
        }
    }
    
}
