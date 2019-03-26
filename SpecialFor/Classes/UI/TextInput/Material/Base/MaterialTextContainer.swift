//
//  MaterialTextView.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/22/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let defaultConfig = NynjaMTIConfig()

class MaterialTextContainer: View, MaterialTextInput {
    
    var validators: [MTIValidator] = []
    
    var validationHandler: MTIValidationHandler?
    var textChanged: MTITextChangedHandler?
    var shouldTextChanged: MTIShouldChangeTextHandler?
    
    var state: MaterialTextInputState = .inactive {
        didSet { didStateChanged() }
    }
    
    var config: MTIConfigProtocol = defaultConfig {
        didSet { updateInput(with: config) }
    }
    
    var text: String = "" {
        didSet {
            if !text.isEmpty {
                updateFloatingState(.collapsed, animated: false)
            } else if state == .inactive {
                updateFloatingState(.default, animated: false)
            }
        }
    }
    
    var font: UIFont? = defaultConfig.font
    var textColor: UIColor = defaultConfig.textColor
    var cursorColor: UIColor = defaultConfig.cursorColor
    var keyboardType: UIKeyboardType = defaultConfig.keyboardType
    var isSecureTextEntry: Bool = defaultConfig.isSecureTextEntry
    
    var activeSeparatorHeight: CGFloat = defaultConfig.activeSeparatorHeight {
        didSet { adjustSeparatorHeight(activeSeparatorHeight, state: .active) }
    }
    
    var inactiveSeparatorHeight: CGFloat = defaultConfig.inactiveSeparatorHeight {
        didSet { adjustSeparatorHeight(inactiveSeparatorHeight, state: .inactive) }
    }
    
    var activeSeparatorColor: UIColor = defaultConfig.activeSeparatorColor {
        didSet { adjustSeparatorColor(activeSeparatorColor, state: .active) }
    }
    
    var inactiveSeparatorColor: UIColor = defaultConfig.inactiveSeparatorColor {
        didSet { adjustSeparatorColor(inactiveSeparatorColor, state: .inactive) }
    }
    
    var infoProvider: InputInfoProvider {
        return infoContainer
    }
    
    var floatingPlaceholderProvider: FloatingPlaceholderProvider {
        return floatingContainer
    }
    
    // MARK: - Views

    private(set) lazy var infoContainer: InputInfoContainer = {
        let view = InputInfoContainer()
        
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private(set) lazy var floatingContainer: FloatingPlaceholderContainer = {
        let view = FloatingPlaceholderContainer()
        
        infoContainer.inputContainer.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    
    // MARK: - Setup
    
    override func baseSetup() {
        super.baseSetup()
        
        updateInput(with: config)
        setupTestingKeys()
    }
    
    private func updateInput(with config: MTIConfigProtocol) {
        font = config.font
        textColor = config.textColor
        
        placeholderFont = config.placeholderFont
        placeholderCollapsedFontSize = config.placeholderCollapsedFontSize
        placeholderColor = config.placeholderColor
        
        activeSeparatorHeight = config.activeSeparatorHeight
        inactiveSeparatorHeight = config.inactiveSeparatorHeight
        
        infoFont = config.infoFont
        warningColor = config.warningColor
        successColor = config.successColor
    }
    
    
    // MARK: - Private
    
    private func adjustSeparatorHeight(_ height: CGFloat, state: MaterialTextInputState) {
        if state == self.state {
            separatorHeight = height
        }
    }
    
    private func adjustSeparatorColor(_ color: UIColor, state: MaterialTextInputState) {
        if state == self.state {
            separatorColor = color
        }
    }
}


extension MaterialTextContainer {
    
    private enum Keys: String {
        case infoContainer        = "material_info_container"
        case floatingContainer    = "material_floating_container"
    }
    
    func setupTestingKeys() {
        infoContainer.accessibilityIdentifier       = Keys.infoContainer.rawValue
        floatingContainer.accessibilityIdentifier   = Keys.floatingContainer.rawValue
    }
}
