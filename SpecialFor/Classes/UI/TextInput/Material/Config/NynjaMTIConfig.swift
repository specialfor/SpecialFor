//
//  NynjaMITConfig.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/22/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

fileprivate let defaultFont = UIFont.makeFont(with: FontFamily.NotoSans.regular.name, height: CGFloat(22).adjustedByWidth)!
fileprivate let defaultColor = UIColor.nynja.mainRed
fileprivate let darkGrayColor = UIColor.nynja.manatee

struct NynjaMTIConfig: MTIConfigProtocol {
    
    let font: UIFont = defaultFont
    let textColor: UIColor = UIColor.nynja.white
    
    let cursorColor: UIColor = defaultColor
    let keyboardType: UIKeyboardType = .default
    let isSecureTextEntry = false
    
    let placeholderFont: UIFont = defaultFont
    let placeholderCollapsedFontSize: CGFloat = UIFont.makeFont(with: FontFamily.NotoSans.regular.name,
                                                         height: CGFloat(17).adjustedByWidth)!.pointSize
    let placeholderColor: UIColor = darkGrayColor
    
    let activeSeparatorHeight: CGFloat = 2
    let inactiveSeparatorHeight: CGFloat = 1
    var activeSeparatorColor: UIColor = defaultColor
    var inactiveSeparatorColor: UIColor = darkGrayColor
    
    let infoFont: UIFont? = UIFont.makeFont(with: FontFamily.NotoSans.medium.name, height: CGFloat(17).adjustedByWidth)
    let warningColor: UIColor = defaultColor
    let successColor: UIColor = UIColor.nynja.callGreen
    
}
