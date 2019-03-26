//
//  BaseButton.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
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
    
    func baseSetup() { }
}
