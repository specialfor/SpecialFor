//
//  InputsCachePolicy.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 7/23/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

protocol InputsCachePolicy: UITextInputTraits {
    
    var autocorrectionType: UITextAutocorrectionType { get set }
    var shouldCacheInputs: Bool { get set }
}

extension InputsCachePolicy {
    
    var shouldCacheInputs: Bool {
        get {
            return autocorrectionType != .no
        }
        set {
            if newValue {
                autocorrectionType = .default
            } else {
                autocorrectionType = .no
            }
        }
    }
}

extension UITextField: InputsCachePolicy {}
extension UITextView: InputsCachePolicy {}
