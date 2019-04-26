//
//  MaterialTextView.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/19/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import SnapKit

class MaterialTextView: MaterialTextContainer {
    // MARK: - MaterialTextInput

    override var text: String {
        didSet { textView.text = text }
    }

    override var font: UIFont? {
        didSet { textView.font = font }
    }

    override var textColor: UIColor {
        didSet { textView.textColor = textColor }
    }

    override var cursorColor: UIColor {
        didSet { textView.tintColor = cursorColor }
    }

    // MARK: - Views

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = font
        textView.backgroundColor = .clear
        textView.tintColor = cursorColor
        textView.textColor = textColor

        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0

        floatingContainer.inputContainer.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        return textView
    }()

    // MARK: - Setup

    override func baseSetup() {
        super.baseSetup()

        textView.delegate = self
        textView.accessibilityIdentifier = "material_text_view"
    }
}

extension MaterialTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        beginEditingText()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        endEditingText()
    }

    func textViewDidChange(_ textView: UITextView) {
        text = textView.text
        textChanged?(self)
        validate(text: text)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return shouldTextChanged?(self, range, text) ?? true
    }
}
