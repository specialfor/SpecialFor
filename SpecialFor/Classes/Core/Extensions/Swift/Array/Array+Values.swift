//
//  Array+Values.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

extension Array {
    func values<T>(of keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
}
