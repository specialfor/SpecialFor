//
//  Identifiable.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 7/9/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

/// The protocol add `id` property which is able to use as unique identifier.
/// Applicable only for classes, because `id` is instance of `ObjectIdentifier`.
protocol Identifiable: class {
    var id: ObjectIdentifier { get }
}

extension Identifiable {
    
    var id: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
}
