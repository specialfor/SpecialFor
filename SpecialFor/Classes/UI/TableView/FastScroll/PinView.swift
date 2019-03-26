//
//  PinView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/13/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

class PinView: BaseView {
    
    // MARK: Views
    lazy var titleLabel: UILabel = {
        let height = CGFloat(44.0.adjustedByWidth)
        
        let label = UILabel(height: height,
                            color: UIColor.nynja.white,
                            fontName: FontFamily.NotoSans.bold.name,
                            textAlignment: .center)
        
        self.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.height.equalTo(height)
            
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        })
        
        return label
    }()
    
    // MARK: Setup
    override func baseSetup() {
        super.baseSetup()
        
        setupTestingKeys()
        self.backgroundColor = UIColor.nynja.mainRed
    }
    
    // MARK: UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight, .bottomLeft], radius: self.bounds.width / 2)
    }
    
}


// MARK: - Testable

extension PinView: TestableViewProtocol {
    
    private enum Keys: String {
        case titleLabel         = "title_label"
    }
    
    func setupTestingKeys() {
        titleLabel.accessibilityIdentifier          = Keys.titleLabel.rawValue
    }
    
}