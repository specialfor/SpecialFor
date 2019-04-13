//
//  Array+Remove.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) {
        guard let index = index(of: element) else {
            return
        }
        remove(at: index)
    }
    
    public mutating func remove(at indexes: [Index]) {
        indexes.sorted(by: >).forEach { remove(at: $0) }
    }
}
