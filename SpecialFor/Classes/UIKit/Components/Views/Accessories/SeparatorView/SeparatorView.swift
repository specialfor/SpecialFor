//
//  SeparatorView.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 15.05.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

private let height: CGFloat = 1

public final class SeparatorView: View {
    
    public var color: UIColor = .darkGray {
        didSet {
            backgroundColor = color
        }
    }
    
    
    // MARK: - View
    
    public override func baseSetup() {
        super.baseSetup()
        
        backgroundColor = color
        snp.makeConstraints { maker in
            maker.height.equalTo(height)
        }
    }
}
