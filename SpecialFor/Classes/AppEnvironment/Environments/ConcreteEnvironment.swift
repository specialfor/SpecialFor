//
//  ConcreteEnvironment.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/5/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import Foundation

public final class ConcreteEnvironment: Environment {
    public var bundle: Bundle?
    
    public init(bundle: Bundle?) {
        self.bundle = bundle
    }
}

public extension ConcreteEnvironment {
    static let main = ConcreteEnvironment(bundle: .main)
    
    public convenience init<T: AnyObject>(token: T.Type) {
        self.init(bundle: Bundle(for: token))
    }
}
