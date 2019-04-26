//
//  xor.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 1/19/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

precedencegroup BooleanPrecedence { associativity: left }
infix operator ^^: BooleanPrecedence

public func ^^ (lhs: Bool, rhs: Bool) -> Bool {
    return lhs != rhs
}
