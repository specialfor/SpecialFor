//
//  FloatingPlaceholderContainer.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let collapsedFontSize: CGFloat = 14.0

class FloatingPlaceholderContainer: BaseView, FloatingPlaceholderProvider {
    private typealias TransformOptions = (transform: CGAffineTransform, horizontalInset: Int)
    
    /// Default: 12.0
    var placeholderCollapsedFontSize: CGFloat = collapsedFontSize {
        willSet { placeholderCollapsedFont = placeholderFont.withSize(newValue) }
    }
    
    /// Default: system font with size = 16.0
    var placeholderFont: UIFont = UIFont.systemFont(ofSize: 16.0) {
        willSet { adjustPlacholderHeight(with: newValue) }
    }
    
    var placeholder: String? {
        willSet { placeholderLabel.text = newValue }
    }
    
    /// Default: .gray
    var placeholderColor: UIColor = .gray {
        willSet { placeholderLabel.textColor = newValue }
    }
    
    /// Default: .default
    var floatingState: FloatingState {
        get { return _floatingState }
        set { updateFloatingState(newValue, animated: true) }
    }
    
    private var _floatingState: FloatingState = .default
    
    /// Default: system font with size = 14.0
    private var placeholderCollapsedFont: UIFont = UIFont.systemFont(ofSize: collapsedFontSize) {
        willSet {
            adjustTopInset()
            adjustPlacholderHeight(with: newValue)
        }
    }
    
    private var collapsedHeight: CGFloat {
        return placeholderHeight(from: placeholderCollapsedFont)
    }
    
    private var height: CGFloat {
        return placeholderHeight(from: placeholderFont)
    }
    
    
    // MARK: - Views
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        
        label.font = placeholderFont
        label.text = placeholder
        label.textColor = placeholderColor
        label.isUserInteractionEnabled = false
        
        self.addSubview(label)
        
        return label
    }()
    
    private(set) lazy var inputContainer: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(collapsedHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    
    // MARK: - Setup
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if _floatingState == .collapsed {
            let horizontalInset = transformOptions(for: _floatingState).horizontalInset
            updatePlaceholderHorizontalInset(horizontalInset)
        }
    }
    
    override func baseSetup() {
        super.baseSetup()
        
        inputContainer.isHidden = false
        confgurePlaceholderLayout()
        
        setupTestingKeys()
    }
    
    
    // MARK: - Update
    
    func updateFloatingState(_ state: FloatingState, animated: Bool) {
        let prevState = _floatingState
        _floatingState = state
        updatePlaceholderPosition(from: prevState, to: state, animated: animated)
    }
    
    
    // MARK: - Private
    
    private func confgurePlaceholderLayout() {
        placeholderLabel.setContentHuggingPriority(.required, for: .vertical)
        
        placeholderLabel.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.top.equalTo(collapsedHeight)
            make.left.right.equalToSuperview()
        }
    }
    
    private func adjustTopInset() {
        if _floatingState == .default {
            updatePlaceholderTopInset(self.collapsedHeight)
        }
        
        inputContainer.snp.updateConstraints { $0.top.equalTo(self.collapsedHeight) }
    }
    
    private func updatePlaceholderHorizontalInset(_ inset: Int) {
        self.placeholderLabel.snp.updateConstraints { make in
            make.left.right.equalToSuperview().offset(-inset)
        }
    }
    
    private func updatePlaceholderTopInset(_ inset: CGFloat) {
        placeholderLabel.snp.updateConstraints { $0.top.equalTo(inset) }
    }
    
    private func updatePlaceholderHeight(_ height: CGFloat) {
        placeholderLabel.snp.updateConstraints { $0.height.equalTo(height) }
    }
    
    
    // MARK: Placeholder Height
    
    private func adjustPlacholderHeight(with font: UIFont?) {
        let height = placeholderHeight(from: font)
        self.updatePlaceholderHeight(height)
    }
    
    private func placeholderHeight(from font: UIFont?) -> CGFloat {
        return font?.lineHeight ?? placeholderLabel.font.lineHeight
    }
    
    private func transformOptions(for state: FloatingState) -> TransformOptions {
        let font: UIFont = state == .default ? placeholderFont : placeholderCollapsedFont
        
        var transform: CGAffineTransform = .identity
        var horizontalInset: CGFloat = 0
        if state == .collapsed {
            let scaleFactor = font.lineHeight / placeholderLabel.font.lineHeight
            
            let width = self.bounds.width
            let targetWidth = floor(width * scaleFactor)
            horizontalInset = (width - targetWidth) * 0.5
            
            transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        }
        
        return (transform, Int(horizontalInset))
    }
    
    // MARK: - Animations
    
    private func updatePlaceholderPosition(from: FloatingState, to: FloatingState, animated: Bool = true) {
        guard from != to else {
            return
        }
        
        let topInset = to == .default ? collapsedHeight : 0
        let height = to == .default ? self.height : collapsedHeight
        
        let transformOptions = self.transformOptions(for: to)
        
        let animations = {
            self.placeholderLabel.transform = transformOptions.transform
            self.updatePlaceholderTopInset(topInset)
            self.updatePlaceholderHeight(height)
            self.updatePlaceholderHorizontalInset(transformOptions.horizontalInset)
        }
        
        if animated {
            animate(animations: animations)
        } else {
            animations()
        }
    }
    
}

extension FloatingPlaceholderContainer {
    
    enum Keys: String {
        case placeholderLabel        = "material_placeholder_label"
        case inputContainer          = "material_floating_input_container"
        
        func allValues() -> [FloatingPlaceholderContainer.Keys] {
            return [
                .placeholderLabel,
                .inputContainer
            ]
        }
    }
    
    func setupTestingKeys() {
        placeholderLabel.accessibilityIdentifier  = Keys.placeholderLabel.rawValue
        inputContainer.accessibilityIdentifier    = Keys.inputContainer.rawValue
    }
    
}
