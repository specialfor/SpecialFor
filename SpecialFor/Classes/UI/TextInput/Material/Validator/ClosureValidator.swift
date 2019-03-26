//
//  ClosureValidator.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/26/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

final class ClosureValidator: MTIValidator {
    private let closure: (String) -> InputInfo?
    
    init(closure: @escaping (String) -> InputInfo?) {
        self.closure = closure
    }
    
    func validate(text: String) -> InputInfo? {
        return closure(text)
    }
}
