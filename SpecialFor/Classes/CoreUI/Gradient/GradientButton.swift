//
//  GradientButton.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/11/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

public class GradientButton: UIButton {
    
    // TODO: make @IBDesignable
    public var startColor: UIColor
    public var endColor: UIColor
    
    
    // MARK: Init
    
    public init(frame: CGRect = CGRect.zero, startColor: UIColor, endColor: UIColor) {
        self.startColor = startColor
        self.endColor = endColor
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Draw
    
    // TODO: look into layer implementation
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.cgColor, endColor.cgColor]
        
        drawLinearGradient(in: context, colors: colors, direction: .fromTop)
    }
}
