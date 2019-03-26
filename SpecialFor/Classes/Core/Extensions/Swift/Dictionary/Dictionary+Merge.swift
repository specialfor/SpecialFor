//
//  Dictionary+Merge.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 7/27/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension Dictionary {
    
    public func mergingUniquingFirst(with other: [Key: Value]) -> [Key: Value] {
        return (try? merging(other, uniquingKeysWith: uniquingUsingFirst)) ?? self
    }
    
    public mutating func mergeUniquingFirst(with other: [Key: Value]) {
        try? merge(other, uniquingKeysWith: uniquingUsingFirst)
    }
    
    public mutating func mergeUniquingOther(with other: [Key: Value]) {
        try? merge(other, uniquingKeysWith: uniquingUsingOther)
    }
    
    private func uniquingUsingFirst(value: Value, secondValue: Value) throws -> Value {
        return value
    }
    
    private func uniquingUsingOther(value: Value, secondValue: Value) throws -> Value {
        return secondValue
    }
}
