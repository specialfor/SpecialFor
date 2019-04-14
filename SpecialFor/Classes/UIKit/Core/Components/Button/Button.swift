//
//  Button.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

public class Button: UIButton {
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
}
