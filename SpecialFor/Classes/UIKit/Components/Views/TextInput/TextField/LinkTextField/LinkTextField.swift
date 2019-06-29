//
//  LinkTextField.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

public final class LinkTextField: MaterialTextField {
    public var domen: String = "" {
        willSet { setupDomen(newValue, oldDomen: domen) }
    }
    
    public var link: String {
        get { return String(text[linkRange]) }
        set { setupLink(newValue) }
    }
    
    public var linkValidator: LinkValidator?
    
    // MARK: - Subviews
    
    private(set) lazy var actionButton: UIButton = {
        let button = UIButton()
        
        let side = 44.0
        let leftInset = 8.0
        
        floatingContainer.snp.updateConstraints { make in
            make.right.equalTo(-(side + leftInset))
        }
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(side)
            make.right.equalToSuperview()
            make.left.equalTo(floatingContainer.snp.right).offset(leftInset)
            make.centerY.equalTo(floatingContainer)
        }
        
        return button
    }()
    
    // MARK: - Setup
    
    public override func baseSetup() {
        super.baseSetup()
        actionButton.accessibilityIdentifier = "action_button"
        actionButton.setImage(#imageLiteral(resourceName: "ic_refresh"), for: .normal)
    }
    
    // MARK: - Logic
    
    private func setupDomen(_ domen: String, oldDomen: String) {
        linkValidator?.domen = domen
        let range = oldDomen.startIndex..<oldDomen.endIndex
        text = text.replacingCharacters(in: range, with: domen)
    }
    
    private func setupLink(_ link: String) {
        text = text.replacingCharacters(in: linkRange, with: link)
    }
    
    private var linkRange: Range<String.Index> {
        return domen.endIndex..<text.endIndex
    }
    
    // MARK: - Actions
    
    override func editingChanged() {
        super.editingChanged()
        linkValidator?.materialTextInputDidChange(self)
    }
    
    // MARK: - UITextFieldDelegate
    
    override public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isValid = linkValidator?.materialTextInput(self, shouldChangeTextIn: range, replacementText: text) ?? true
        return isValid && super.textField(textField, shouldChangeCharactersIn: range, replacementString: text)
    }
}
