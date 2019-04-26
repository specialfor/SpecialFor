//
//  Array+Values.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

public extension Array {
    func values<T>(_ getter: (Element) -> T) -> [T] {
        return map(getter)
    }
    
    func values<T>(of keyPath: KeyPath<Element, T>) -> [T] {
        return values {
            $0[keyPath: keyPath]
        }
    }
}
