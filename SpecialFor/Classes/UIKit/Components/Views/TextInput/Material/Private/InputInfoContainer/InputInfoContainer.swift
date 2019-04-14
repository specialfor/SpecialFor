//
//  InputInfoContainer.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import SnapKit

fileprivate let _separatorHeight: CGFloat = 1.0

final class InputInfoContainer: View, InputInfoProvider {
    
    
    // MARK: - Info
    private var workItem: DispatchWorkItem?
    
    var info: InputInfo? {
        didSet {
            if (oldValue?.text ?? "").isEmpty {
                setupInfoLabel(with: info)
            } else {
                workItem?.cancel()
                workItem = DispatchWorkItem { [weak self] in
                    self?.setupInfoLabel(with: self?.info)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem!)
            }
        }
    }
    
    /// Default: .red
    var warningColor: UIColor = .red {
        didSet { adjustInfoColor(with: .warning, color: warningColor) }
    }
    
    /// Default: .green
    var successColor: UIColor = .green {
        didSet { adjustInfoColor(with: .success, color: successColor) }
    }
    
    /// Default: system font with size = 14.0
    var infoFont: UIFont? = UIFont.systemFont(ofSize: 14.0) {
        didSet { adjustInfoFont(with: infoFont) }
    }
    
    
    // MARK: - Separator
    
    /// Default: true
    var shouldShowSeparator: Bool = true {
        didSet { separator.isHidden = !shouldShowSeparator }
    }
    
    /// Default: .gray
    var separatorColor: UIColor = .gray {
        didSet { separator.backgroundColor = separatorColor }
    }
    
    /// Default: 1.0
    var separatorHeight: CGFloat = _separatorHeight {
        didSet { separator.snp.updateConstraints { $0.height.equalTo(separatorHeight) } }
    }
    
    // MARK: - Views
    
    private(set) lazy var inputContainer: UIView = {
        let view = UIView()
        
        self.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = infoFont
        
        label.setContentHuggingPriority(.required, for: .vertical)
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(inputContainer.snp.bottom).offset(8.0)
            make.height.equalTo(label.font.lineHeight)
            make.left.right.bottom.equalToSuperview()
        }
        
        return label
    }()
    
    private lazy var separator: UIView = {
        let separator = UIView()
        
        self.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.height.equalTo(separatorHeight)
            make.top.equalTo(inputContainer.snp.bottom).offset(2.0)
            make.left.right.equalToSuperview()
        }
        
        return separator
    }()
    
    // MARK: - Setup
    
    override func baseSetup() {
        super.baseSetup()
        
        infoLabel.isHidden = false
        separator.backgroundColor = separatorColor
        
        setupTestingKeys()
    }
    
    
    // MARK: - Private
    
    private func setupInfoLabel(with info: InputInfo?) {
        let currentText = infoLabel.text ?? ""
        let shouldAnimate = currentText != info?.text
        
        if shouldAnimate {
            infoLabel.alpha = 0
        }
        
        if let info = self.info {
            infoLabel.text = info.text
            infoLabel.textColor = info.kind == .warning ? warningColor : successColor
            scrollIfNotVisible()
        } else {
            infoLabel.text = ""
        }
        
        if shouldAnimate {
            infoLabel.animate {
                self.infoLabel.alpha = 1
            }
        }
    }
    
    private func scrollIfNotVisible() {
        guard let scrollView = self.firstAncestor(ofType: UIScrollView.self) else {
            return
        }
        
        let rect = infoLabel.convert(infoLabel.bounds, to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    private func adjustInfoColor(with kind: InputInfo.Kind, color: UIColor) {
        if info?.kind == kind {
            infoLabel.textColor = color
        }
    }
    
    private func adjustInfoFont(with font: UIFont?) {
        infoLabel.font = infoFont
        infoLabel.snp.updateConstraints { $0.height.equalTo(infoLabel.font.lineHeight) }
    }
    
}

extension InputInfoContainer {
    
    private enum Keys: String {
        case inputContainer        = "material_input_container"
        case infoLabel             = "material_info_label"
        case separator             = "material_separator"
    }
    
    func setupTestingKeys() {
        inputContainer.accessibilityIdentifier  = Keys.inputContainer.rawValue
        infoLabel.accessibilityIdentifier       = Keys.infoLabel.rawValue
        separator.accessibilityIdentifier       = Keys.separator.rawValue
    }
}
