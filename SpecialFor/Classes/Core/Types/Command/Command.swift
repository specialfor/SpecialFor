//
//  Command.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 3/2/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

public typealias Command = CommandWith<Void>

public struct CommandWith<T> {
    public let closure: (T) -> Void
    
    public init(closure: @escaping (T) -> Void) {
        self.closure = closure
    }
    
    public func perform(with value: T) {
        closure(value)
    }
    
    public static func ~> (value: T, command: CommandWith) {
        command.closure(value)
    }
}

public func ~> <T>(value: T, command: CommandWith<T>?) {
    command?.closure(value)
}

public extension CommandWith where T == Void {
    func perform() {
        closure(())
    }
}
