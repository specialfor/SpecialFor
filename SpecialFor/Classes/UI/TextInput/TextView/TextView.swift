//
//  TextView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 7/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

class TextView: UITextView {
    
    
    // MARK: - Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    
    // MARK: - Base setup
    
    func baseSetup() {
        shouldCacheInputs = false
    }
    
    
}
