//
//  LinkValidator.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

enum LengthWarning {
    case minLength
    case maxLength
}

final class LinkValidator: NSObject, UITextViewDelegate {
    typealias ValidationClosure = ((ValidationKind) -> Void)
    
    enum ValidationKind {
        case invalidLength(LengthWarning, length: Int)
        case invalidSymbols
        case valid
    }
    
    var validationClosure: ValidationClosure?
    
    var domen: String
    var minLength: Int = 0
    var maxLength: Int?
    
    init(domen: String, minLength: Int = 0, maxLength: Int? = nil, validationClosure: ValidationClosure? = nil) {
        self.domen = domen
        self.minLength = minLength
        self.maxLength = maxLength
        self.validationClosure = validationClosure
    }
    
    func materialTextInput(_ input: MaterialTextInput,
                           shouldChangeTextIn range: NSRange,
                           replacementText text: String) -> Bool {
        
        guard range.location >= domen.count else {
            return false
        }
        
        return true
    }
    
    func materialTextInputDidChange(_ input: MaterialTextInput) {
        guard let validationClosure = self.validationClosure else {
            return
        }
        
        let range = domen.startIndex..<domen.endIndex
        let link = input.text.replacingCharacters(in: range, with: "")

        if link.count < minLength {
            validationClosure(.invalidLength(.minLength, length: minLength))
        } else if let maxLength = self.maxLength, link.count > maxLength {
            validationClosure(.invalidLength(.maxLength, length: maxLength))
        } else if !link.containsOnly(characters: Constants.Validation.usernameCharacters) {
            validationClosure(.invalidSymbols)
        } else {
            validationClosure(.valid)
        }
    }
    
}
