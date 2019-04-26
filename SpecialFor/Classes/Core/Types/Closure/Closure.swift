//
//  Closure.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//

import Foundation

public typealias Closure = () -> Void
public typealias ClosureWith<T> = (T) -> Void
public typealias ClosureProducer<T> = () -> T
public typealias ThrowableClosureProducer<T> = () throws -> T

public func call<T>(_ closure: ClosureProducer<T>) -> T {
    return closure()
}

public func call(_ closure: Closure) {
    return closure()
}
