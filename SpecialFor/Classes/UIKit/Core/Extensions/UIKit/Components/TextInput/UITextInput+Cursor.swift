//
//  UITextInput+Cursor.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 29.04.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UITextInput {
    public var cursorPosition: Int? {
        get {
            guard let selectedRange = selectedTextRange else {
                return nil
            }
            return offset(from: beginningOfDocument, to: selectedRange.start)
        }
        set {
            if let newValue = newValue {
                if let newPosition = position(from: beginningOfDocument, offset: newValue) {
                    selectedTextRange = textRange(from: newPosition, to: newPosition)
                }
            } else {
                selectedTextRange = nil
            }
        }
    }
}
