//
//  MITConfigProtocol.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/22/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

protocol MTIConfigProtocol {
  
    var font: UIFont { get }
    var textColor: UIColor { get }
    
    var cursorColor: UIColor { get }
    
    var placeholderFont: UIFont { get }
    var placeholderCollapsedFontSize: CGFloat { get }
    var placeholderColor: UIColor { get }
    
    var activeSeparatorHeight: CGFloat { get }
    var inactiveSeparatorHeight: CGFloat { get }
    var activeSeparatorColor: UIColor { get }
    var inactiveSeparatorColor: UIColor { get }
    
    var infoFont: UIFont? { get }
    var warningColor: UIColor { get }
    var successColor: UIColor { get }
    
}
