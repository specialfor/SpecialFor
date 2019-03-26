//
//  SeparatorView.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 15.05.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit
import SnapKit

final class SeparatorView: UIView {
    
    static let height: CGFloat = 1
    
    var color: UIColor = UIColor.nynja.backgroundGray {
        didSet {
            backgroundColor = color
        }
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = color
        snp.makeConstraints { maker in
            maker.height.equalTo(SeparatorView.height)
        }
    }
}
