//
//  LinkValidator.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

public enum LengthWarning {
    case minLength
    case maxLength
}

private let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
private let usernameCharacters = "\(letters)\(letters.lowercased())0123456789_"

public final class LinkValidator: NSObject, UITextViewDelegate {
    public typealias ValidationClosure = ClosureWith<ValidationKind>
    
    public enum ValidationKind {
        case invalidLength(LengthWarning, length: Int)
        case invalidSymbols
        case valid
    }
    
    public var validationClosure: ValidationClosure?
    
    public var domen: String
    public var minLength: Int = 0
    public var maxLength: Int?
    
    public init(domen: String, minLength: Int = 0, maxLength: Int? = nil, validationClosure: ValidationClosure? = nil) {
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
        } else if !link.containsOnly(characters: usernameCharacters) {
            validationClosure(.invalidSymbols)
        } else {
            validationClosure(.valid)
        }
    }
    
}
