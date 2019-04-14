//
//  AppEnvironment.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/5/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import Foundation

public final class AppEnvironment {
    public private(set) static var environments: [Environment] = [ConcreteEnvironment.main]
    
    public static var current: Environment? {
        return environments.last
    }
    
    public static func push(_ environment: Environment) {
        environments.append(environment)
    }
    
    public static func pop(_ environment: Environment) -> Environment? {
        return environments.removeLast()
    }
}
