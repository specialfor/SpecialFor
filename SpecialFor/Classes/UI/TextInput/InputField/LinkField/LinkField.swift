//
//  LinkField.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

final class LinkField: MaterialTextField {
    
    var domen: String = "" {
        willSet { setupDomen(newValue, oldDomen: domen) }
    }
    
    var link: String {
        get { return String(text[linkRange]) }
        set { setupLink(newValue) }
    }
    
    var linkValidator: LinkValidator?
    
    // MARK: - Views
    
    private(set) lazy var actionButton: UIButton = {
        let button = UIButton()
        
        let side = 44.0.adjustedByWidth
        let leftInset = 8.0.adjustedByWidth
        
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
    
    override func baseSetup() {
        super.baseSetup()
        actionButton.accessibilityIdentifier = "action_button"
        actionButton.setImage(UIImage.nynja.LinkField.icRefresh.image, for: .normal)
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
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isValid = linkValidator?.materialTextInput(self, shouldChangeTextIn: range, replacementText: text) ?? true
        return isValid && super.textField(textField, shouldChangeCharactersIn: range, replacementString: text)
    }
    
}
