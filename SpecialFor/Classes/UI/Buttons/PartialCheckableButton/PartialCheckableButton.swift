
//
//  PartialCheckableButton.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

class PartialCheckableButton: BaseView {
    
    override var activatedViews: [UIView] {
        return [titleLabel, button]
    }
    
    var viewModel: ViewModel? {
        didSet { setup(with: viewModel) }
    }
    
    // MARK: - Views
    
    private lazy var button: UIButton = {
        let button = UIButton()
        
        button.contentHorizontalAlignment = .right
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(-Constraints.TitleLabel.rightInset)
        }
        
        return label
    }()
    
    // MARK: - Base Setup

    override func baseSetup() {
        super.baseSetup()
        
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        setupTestingKeys()
    }

    private func setup(with model: ViewModel?) {
        titleLabel.text = model?.info.title
        button.setImage(model?.info.image, for: .normal)
    }

    
    // MARK: - Actions
    
    @objc private func tapped() {
        viewModel?.info.action()
    }
    
}


// MARK: - ViewModel

extension PartialCheckableButton {
    typealias ActionHandler = () -> Void
    
    struct ViewModel {
        let state: State
        let info: Info
    }
    
    enum State {
        case empty
        case partial
        case filled
    }
    
    struct Info {
        let title: String?
        let image: UIImage?
        let action: ActionHandler
    }
}


// MARK: - Contsraints

extension PartialCheckableButton {
    
    enum Constraints {
        
        enum TitleLabel {
            static let height = CGFloat(20)
            static let rightInset = 32.0
        }
        
    }
    
}


// MARK: - Testable

extension PartialCheckableButton {
    
    private enum Keys: String {
        case button         = "button"
        case titleLabel     = "title_label"
    }
    
    func setupTestingKeys() {
        button.accessibilityIdentifier       = Keys.button.rawValue
        titleLabel.accessibilityIdentifier   = Keys.titleLabel.rawValue
    }
}
