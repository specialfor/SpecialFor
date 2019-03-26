//
//  GCD.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//

import Foundation

public func async(queue: DispatchQueue = .main, block: @escaping Closure) {
    let workItem = DispatchWorkItem(block: block)
    async(queue: queue, workItem: workItem)
}

public func async(queue: DispatchQueue = .main, workItem: DispatchWorkItem) {
    queue.async(execute: workItem)
}

public func async(queue: DispatchQueue = .main, after timeInterval: TimeInterval, block: @escaping Closure) {
    let workItem = DispatchWorkItem(block: block)
    async(queue: queue, after: timeInterval, workItem: workItem)
}

public func async(queue: DispatchQueue = .main, after timeInterval: TimeInterval, workItem: DispatchWorkItem) {
    queue.asyncAfter(deadline: .now() + timeInterval, execute: workItem)
}

public func sync(queue: DispatchQueue = .main, block: Closure) {
    queue.sync(execute: block)
}

public func sync(queue: DispatchQueue = .main, workItem: DispatchWorkItem) {
    queue.sync(execute: workItem)
}

public func sync<T>(queue: DispatchQueue = .main, block: ThrowableClosureProducer<T>) throws -> T {
    return try queue.sync(execute: block)
}
