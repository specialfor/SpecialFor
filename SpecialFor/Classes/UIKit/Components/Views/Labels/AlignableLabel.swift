//
//  AlignableLabel.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 10/20/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

public final class AlignableLabel: UILabel {
    /// Determines vertical alignement for label
    /// Default: center
    public var verticalAlignement: VerticalAlignment = .center {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func drawText(in rect: CGRect) {
        var newRect = rect

        let sizeThatFits = self.sizeThatFits(rect.size)
        if verticalAlignement == .top {
            newRect.size.height = sizeThatFits.height
        } else if verticalAlignement == .bottom {
            newRect.origin.y += newRect.size.height - sizeThatFits.height
            newRect.size.height = sizeThatFits.height
        }
        
        super.drawText(in: newRect)
    }
}

extension AlignableLabel {
    public enum VerticalAlignment {
        case top
        case center
        case bottom
    }
}
