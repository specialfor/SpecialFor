
//
//  PartialCheckableButton.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit
import SnapKit

public final class PartialCheckableButton: View {
    
    public override var activatedViews: [UIView] {
        return [titleLabel, button]
    }
    
    public var viewModel: ViewModel? {
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

    public override func baseSetup() {
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
    
    public struct ViewModel {
        public let state: State
        public let info: Info

        public init(state: State, info: Info) {
            self.state = state
            self.info = info
        }
    }
    
    public enum State {
        case empty
        case partial
        case filled
    }
    
    public struct Info {
        public let title: String?
        public let image: UIImage?
        public let action: Closure

        public init(title: String?, image: UIImage?, action: @escaping Closure) {
            self.title = title
            self.image = image
            self.action = action
        }
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
