//
//  NynjaMITConfig.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/22/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

private let defaultFont = UIFont.preferredFont(forTextStyle: .title1)
private let defaultColor = UIColor.red
private let darkGrayColor = UIColor.darkGray

struct NynjaMTIConfig: MTIConfigProtocol {
    let font: UIFont = defaultFont
    let textColor: UIColor = .white
    
    let cursorColor: UIColor = defaultColor
    let keyboardType: UIKeyboardType = .default
    let isSecureTextEntry = false
    
    let placeholderFont: UIFont = defaultFont
    let placeholderCollapsedFontSize: CGFloat = UIFont.preferredFont(forTextStyle: .body).pointSize
    let placeholderColor: UIColor = darkGrayColor
    
    let activeSeparatorHeight: CGFloat = 2
    let inactiveSeparatorHeight: CGFloat = 1
    var activeSeparatorColor: UIColor = defaultColor
    var inactiveSeparatorColor: UIColor = darkGrayColor
    
    let infoFont: UIFont? = UIFont.preferredFont(forTextStyle: .body)
    let warningColor: UIColor = defaultColor
    let successColor: UIColor = .green
}
