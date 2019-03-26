//
//  ImagePlaceholderField.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/7/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

fileprivate enum Side {
    case left
    case right
}

class ImagePlaceholderField: UIView {
    
    var returnHandler: (() -> Void)?
    
    var leftInset: Double = 16.0 {
        didSet {
            updateFieldInset(leftInset, side: .left)
        }
    }
    
    var rightInset: Double = 0 {
        didSet {
            updateFieldInset(rightInset, side: .right)
        }
    }
    
    var placeholerImage: UIImage? {
        get {
            return placeholderImageView.image
        }
        set {
            placeholderImageView.image = newValue
        }
    }
    
    var placeholder: String? {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
        }
    }
    
    // MARK: Views
    lazy var placeholderImageView: UIImageView = {
        let imgView = UIImageView()
    
        let width = 20.0
        
        self.addSubview(imgView)
        imgView.snp.makeConstraints({ (make) in
            make.width.height.equalTo(width)
            make.centerY.equalToSuperview()
        })
        
        return imgView
    }()
    
    lazy var placeholderLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        let rightInset = 16.0
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.left.equalTo(placeholderImageView.snp.right).offset(4.0)
            make.right.equalTo(-rightInset)
            make.centerY.equalTo(placeholderImageView)
        })
        
        return label
    }()
    
    lazy var textField: TextField = {
        let textField = TextField()
        
        textField.backgroundColor = UIColor.clear
        textField.tintColor = UIColor.red
        textField.textColor = UIColor.white
        
        self.addSubview(textField)
        textField.snp.makeConstraints({ (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(leftInset)
            make.right.equalTo(-rightInset)
            
            make.left.equalTo(placeholderImageView)
        })
        
        return textField
    }()
    
    
    // MARK: Accessibility
    override var accessibilityIdentifier: String? {
        didSet {
            if let identifier = accessibilityIdentifier {
                placeholderLabel.accessibilityIdentifier = "\(identifier)_placeholder_view"
                textField.accessibilityIdentifier = "\(identifier)_text_view"
            } else {
                placeholderLabel.accessibilityIdentifier = nil
                textField.accessibilityIdentifier = nil
            }
        }
    }
    
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    // MARK: Setup
    func baseSetup() {
        textField.isHidden = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(actionTextDidChange(sender:)), for: .editingChanged)
        
        placeholderImageView.isUserInteractionEnabled = false
        placeholderLabel.isUserInteractionEnabled = false
        
        // TODO: image
//        placeholerImage = UIImage.nynja.icParticipantsSearch.image
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.red.cgColor
        
        backgroundColor = UIColor.lightGray
    }
    
    
    // MARK: - First responder
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    // MARK: Actions
    
    func startEditing() {
        textField.becomeFirstResponder()
    }
    
    func finishEditing() {
        textField.resignFirstResponder()
    }
    
    @objc private func actionTextDidChange(sender: UITextField) {
        updatePlaceholder(for: textField.text)
    }
    
    // MARK: Constraints
    private func updateFieldInset(_ inset: Double, side: Side) {
        textField.snp.updateConstraints { (make) in
            switch side {
            case .left:
                make.left.equalTo(inset)
            case .right:
                make.right.equalTo(-inset)
            }
        }
    }
    
    func setText(_ text: String?) {
        textField.text = text
        updatePlaceholder(for: text)
    }
}


// MARK: UITextFieldDelegate
extension ImagePlaceholderField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnHandler?()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updatePlaceholder(for: textField.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatePlaceholder(for: textField.text)
    }
    
    fileprivate func updatePlaceholder(for text: String?) {
        let text = textField.text ?? ""
        togglePlaceholder(shouldHide: !text.isEmpty)
    }
}

// MARK: Show/Hide placeholder
fileprivate extension ImagePlaceholderField {
    
    func togglePlaceholder(shouldHide: Bool) {
        placeholderImageView.isHidden = shouldHide
        placeholderLabel.isHidden = shouldHide
    }
}
