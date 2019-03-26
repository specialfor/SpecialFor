//
//  BaseView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 12/29/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    var activatedViews: [UIView] {
        return []
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    // MARK: - Base Setup
    func baseSetup() {
        activatedViews.activate()
        // NOTE: implement in subclasse if needed
    }
    
}

extension Array where Element == UIView {
    
    func activate() {}
    
}
