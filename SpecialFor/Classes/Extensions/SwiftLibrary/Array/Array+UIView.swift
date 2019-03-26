//
//  Array+UIView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 3/5/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension Array where Element: UIView {
    
    func activate() {}
    
    func removeFromSuperview() {
        self.forEach { $0.removeFromSuperview() }
    }
}
