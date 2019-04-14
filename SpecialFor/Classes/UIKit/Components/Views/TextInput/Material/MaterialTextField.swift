//
//  MaterialTextField.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import SnapKit

public class MaterialTextField: MaterialTextContainer, UITextFieldDelegate {
    
    // MARK: - MaterialTextInput
    
    public override var text: String {
        didSet { textField.text = text }
    }
    
    public override var font: UIFont? {
        didSet { textField.font = font }
    }
    
    public override var textColor: UIColor {
        didSet { textField.textColor = textColor }
    }
    
    public override var cursorColor: UIColor {
        didSet { textField.tintColor = cursorColor }
    }

    public override var keyboardType: UIKeyboardType {
        didSet { textField.keyboardType = keyboardType }
    }

    public override var isSecureTextEntry: Bool {
        didSet { textField.isSecureTextEntry = isSecureTextEntry }
    }

    public var rightView: UIView? {
        didSet { textField.rightView = rightView }
    }

    public var rightViewMode: UITextField.ViewMode = .never {
        didSet { textField.rightViewMode = rightViewMode }
    }

    public var prohibitedOptions: ProhibitedOptions = .none {
        didSet { textField.prohibitedOptions = prohibitedOptions }
    }

    public var autocapitalizationType: UITextAutocapitalizationType = UITextAutocapitalizationType.sentences {
        didSet { textField.autocapitalizationType = autocapitalizationType }
    }

    public func setTextFieldFirstResponder() {
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
    
    public override func baseSetup() {
        super.baseSetup()
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField.accessibilityIdentifier = "material_text_field"
    }
    
    public override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    
    // MARK: - Actions
    
    @objc func editingChanged() {
        text = textField.text ?? ""
        textChanged?(self)
        validate(text: text)
    }
    
    // MARK: - UITextFieldDelegate
 
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        beginEditingText()
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) {
        endEditingText()
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return shouldTextChanged?(self, range, string) ?? true
    }
}
