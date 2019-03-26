//
//  InputInfoProvider.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

protocol InputInfoProvider: class {
    
    // MARK: - Info
    
    var info: InputInfo? { get set }
    
    var warningColor: UIColor { get set }
    var successColor: UIColor { get set }
    
    var infoFont: UIFont? { get set }
    
    
    // MARK: - Separator
    
    var shouldShowSeparator: Bool { get set }
    
    var separatorColor: UIColor { get set }
    var separatorHeight: CGFloat { get set }
    
}
