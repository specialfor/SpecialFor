//
//  View.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 12/29/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

public class View: UIView {
    
    public var activatedViews: [UIView] {
        return []
    }
    
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    
    // MARK: - Base Setup
    
    /// Don't forget to call `super.baseSetup` in subclasess
    func baseSetup() {
        activatedViews.activate()
    }
}
