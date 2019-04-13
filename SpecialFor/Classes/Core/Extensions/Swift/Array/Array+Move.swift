//
//  Array+Move.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

extension Array {
    public mutating func move(at index: Int, to newIndex: Int) {
        let element = remove(at: index)
        insert(element, at: newIndex)
    }
}
