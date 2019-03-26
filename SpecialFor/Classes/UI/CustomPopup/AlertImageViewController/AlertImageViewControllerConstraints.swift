//
//  AlertImageViewControllerConstraints.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 2/21/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension AlertImageViewController {
    
    enum Constraints {
        
        enum popupView {
            static let width = 270
            static let cornerdRadius: CGFloat = 12
        }
        
        enum imageView {
            static let width = 62.0
            static let topInset = 16.0
        }
        
        enum messageLabel {
            static let topInset = 16.0
            static let bottomInset = 24.0
            static let horizontalInset = 16.0
        }
        
    }
    
}
