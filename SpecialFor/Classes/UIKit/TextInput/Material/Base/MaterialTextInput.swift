//
//  MaterialTextInput.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

public enum MaterialTextInputState {
    case active
    case inactive
}

public typealias MTIValidationHandler = (Bool) -> Void
public typealias MTITextChangedHandler = (MaterialTextInput) -> Void
public typealias MTIShouldChangeTextHandler = (MaterialTextInput, NSRange, String) -> Bool

public protocol MaterialTextInput: FloatingPlaceholderProvider, InputInfoProvider {
    
    var infoProvider: InputInfoProvider { get }
    var floatingPlaceholderProvider: FloatingPlaceholderProvider { get }
    
    var validators: [MTIValidator] { get set }
    
    var validationHandler: MTIValidationHandler? { get set }
    var textChanged: MTITextChangedHandler? { get set }
    var shouldTextChanged: MTIShouldChangeTextHandler? { get set }
    
    var state: MaterialTextInputState { get set  }
    
    var config: MTIConfigProtocol { get set }
    
    var text: String { get set }
    var font: UIFont? { get set }
    var textColor: UIColor { get set }
    
    var cursorColor: UIColor { get set }
    
    var activeSeparatorHeight: CGFloat { get set }
    var inactiveSeparatorHeight: CGFloat { get set }
    
    var activeSeparatorColor: UIColor { get set }
    var inactiveSeparatorColor: UIColor { get set }
    
    func didStateChanged()
    
    func beginEditingText()
    func endEditingText()
    
}

public extension MaterialTextInput {
    
    // MARK: - InputInfoProvider
    
    var info: InputInfo? {
        get { return infoProvider.info }
        set { infoProvider.info = newValue }
    }
    
    var warningColor: UIColor {
        get { return infoProvider.warningColor }
        set { infoProvider.warningColor = newValue }
    }
    
    var successColor: UIColor {
        get { return infoProvider.successColor }
        set { infoProvider.successColor = newValue }
    }
    
    var infoFont: UIFont? {
        get { return infoProvider.infoFont }
        set { infoProvider.infoFont = newValue }
    }
    
    var shouldShowSeparator: Bool {
        get { return infoProvider.shouldShowSeparator }
        set { infoProvider.shouldShowSeparator = newValue }
    }
    
    var separatorColor: UIColor {
        get { return infoProvider.separatorColor }
        set { infoProvider.separatorColor = newValue }
    }
    
    var separatorHeight: CGFloat {
        get { return infoProvider.separatorHeight }
        set { infoProvider.separatorHeight = newValue }
    }
    
    
    // MARK: - FloatingPlaceholderProvider
    
    var placeholderCollapsedFontSize: CGFloat {
        get { return floatingPlaceholderProvider.placeholderCollapsedFontSize }
        set { floatingPlaceholderProvider.placeholderCollapsedFontSize = newValue }
    }
    
    var placeholderFont: UIFont {
        get { return floatingPlaceholderProvider.placeholderFont }
        set { floatingPlaceholderProvider.placeholderFont = newValue }
    }
    
    var placeholder: String? {
        get { return floatingPlaceholderProvider.placeholder }
        set { floatingPlaceholderProvider.placeholder = newValue }
    }
    
    var placeholderColor: UIColor {
        get { return floatingPlaceholderProvider.placeholderColor }
        set { floatingPlaceholderProvider.placeholderColor = newValue }
    }
    
    var floatingState: FloatingState {
        get { return floatingPlaceholderProvider.floatingState }
        set { floatingPlaceholderProvider.floatingState = newValue }
    }
    
    func updateFloatingState(_ state: FloatingState, animated: Bool) {
        floatingPlaceholderProvider.updateFloatingState(state, animated: animated)
    }
    
    
    // MARK: - MaterialTextInput
    
    func didStateChanged() {
        let height = state == .active ? activeSeparatorHeight : inactiveSeparatorHeight
        separatorHeight = height
        
        let color = state == .active ? activeSeparatorColor : inactiveSeparatorColor
        separatorColor = color
    }
    
    func beginEditingText() {
        state = .active
        if text.isEmpty {
            floatingPlaceholderProvider.floatingState = .collapsed
        }
    }
    
    func endEditingText() {
        state = .inactive
        if text.isEmpty {
            floatingPlaceholderProvider.floatingState = .default
        }
    }
    
    func validate(text: String) {
        guard !validators.isEmpty else {
            return
        }
        
        let infos = validators
            .map { $0.validate(text: text) }
            .compactMap { $0 }
        info = infos.first
        
        let isValid = info == nil
        validationHandler?(isValid)
    }
}
