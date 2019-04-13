//
//  Array+Extensions.swift
//  Nynja
//
//  Created by Anton Makarov on 24.10.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

extension Array {
    public func count(where predicate: (Element) -> Bool) -> Int {
        var count = 0
        for element in self where predicate(element) {
            count += 1
        }
        return count
    }
}
