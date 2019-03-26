//
//  EmptyStateView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/31/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

class EmptyStateView: BaseView {
    typealias ActionHandler = () -> Void
    
    var actionHandler: ActionHandler?
    
    private var heightConstraint: Constraint?
    private var topInsetConstraint: Constraint?
    
    
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .center
        
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.left.right.equalToSuperview().priority(700)
        }
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(height: Constraints.DescriptionLabel.height,
                            color: UIColor.nynja.manatee,
                            fontName: FontFamily.NotoSans.medium.name,
                            textAlignment: .center)
        
        label.numberOfLines = 2
        
        self.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constraints.DescriptionLabel.topInset)
            make.left.right.equalToSuperview()
        }
        
        return label
    }()
    
    private lazy var actionButton: NynjaButton = {
        let button = NynjaButton()
        
        button.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(0).constraint
            topInsetConstraint = make.top.equalTo(descriptionLabel.snp.bottom)
                .offset(0).constraint
            
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        return button
    }()
    
    
    // MARK: - Setup
    
    override func baseSetup() {
        super.baseSetup()
        actionButton.isHidden = true
    }
    
    func setup(with model: EmptyStateViewModel) {
        imageView.image = model.image
        descriptionLabel.text = model.descriptionText
        
        setupActionButton(with: model.actionViewModel)
    }
    
    private func setupActionButton(with model: EmptyStateViewModel.ActionViewModel?) {
        if let model = model {
            actionButton.setTitle(model.title, for: .normal)
            actionHandler = model.handler
            toggleActionButton(true)
        } else {
            toggleActionButton(false)
        }
    }
    
    private func toggleActionButton(_ shouldShow: Bool) {
        actionButton.toggleIfNeeded(shouldShow) {
            let height = shouldShow ? Constraints.ActionButton.height : 0
            let topInset = shouldShow ? Constraints.ActionButton.topInset : 0
            
            self.actionButton.snp.updateConstraints { make in
                self.heightConstraint?.update(offset: height)
                self.topInsetConstraint?.update(offset: topInset)
            }
        }
    }
    
    
    // MARK: - Actions
    
    @objc private func actionTapped() {
        actionHandler?()
    }
}


extension EmptyStateView {
    
    enum Constraints {
        
        enum DescriptionLabel {
            static let height = CGFloat(22).adjustedByWidth
            static let topInset = 16.0.adjustedByWidth
        }
        
        enum ActionButton {
            static let height = 44.0.adjustedByWidth
            static let topInset = 16.0.adjustedByWidth
        }
    }
}
