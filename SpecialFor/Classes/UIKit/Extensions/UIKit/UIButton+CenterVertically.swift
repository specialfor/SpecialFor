//
//  UIButton+CenterVertically.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 29.05.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIButton {
    
    public func centerVertically(padding: CGFloat) {
        guard
            let imageViewSize = imageView?.bounds.size,
            let titleLabelSize = titleLabel?.bounds.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageViewSize.height),
                                       left: 0.0,
                                       bottom: 0.0,
                                       right: -titleLabelSize.width)
        
        titleEdgeInsets = UIEdgeInsets(top: 0.0,
                                       left: -imageViewSize.width,
                                       bottom: -(totalHeight - titleLabelSize.height),
                                       right: 0.0)
        
        contentEdgeInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: 0.0,
                                         right: 0.0)
    }
}

