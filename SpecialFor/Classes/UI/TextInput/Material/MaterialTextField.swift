//
//  MaterialTextField.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit
import SnapKit

class MaterialTextField: MaterialTextContainer {
    
    // MARK: - MaterialTextInput
    
    override var text: String {
        didSet { textField.text = text }
    }
    
    override var font: UIFont? {
        didSet { textField.font = font }
    }
    
    override var textColor: UIColor {
        didSet { textField.textColor = textColor }
    }
    
    override var cursorColor: UIColor {
        didSet { textField.tintColor = cursorColor }
    }

    override var keyboardType: UIKeyboardType {
        didSet { textField.keyboardType = keyboardType }
    }

    override var isSecureTextEntry: Bool {
        didSet { textField.isSecureTextEntry = isSecureTextEntry }
    }

    var rightView: UIView? {
        didSet { textField.rightView = rightView }
    }

    var rightViewMode: UITextField.ViewMode = .never {
        didSet { textField.rightViewMode = rightViewMode }
    }

    var prohibitedOptions: ProhibitedOptions = .none {
        didSet { textField.prohibitedOptions = prohibitedOptions }
    }

    var autocapitalizationType: UITextAutocapitalizationType = UITextAutocapitalizationType.sentences {
        didSet { textField.autocapitalizationType = autocapitalizationType }
    }

    func setTextFieldFirstResponder() {
        textField.becomeFirstResponder()
    }

    // MARK: - Views
    
    private lazy var textField: TextField = {
        let textField = TextField()
        
        textField.font = font
        textField.backgroundColor = .clear
        textField.tintColor = cursorColor
        textField.textColor = textColor
        
        floatingContainer.inputContainer.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return textField
    }()
    
    
    // MARK: - Setup
    
    override func baseSetup() {
        super.baseSetup()
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.accessibilityIdentifier = "material_text_field"
    }
    
    override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    
    // MARK: - Actions
    
    @objc func editingChanged() {
        text = textField.text ?? ""
        textChanged?(self)
        validate(text: text)
    }
    
}

extension MaterialTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditingText()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endEditingText()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldTextChanged?(self, range, string) ?? true
    }
}
