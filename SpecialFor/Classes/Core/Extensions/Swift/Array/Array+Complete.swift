//
//  Array+Complete.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

extension Array {
    public mutating func complete(to length: Int, with element: Element) {
        guard self.count <= length else {
            return
        }
        
        for _ in self.count..<length {
            self.append(element)
        }
    }
    
    public func completed(to length: Int, with element: Element) -> [Element] {
        var temp = self
        temp.complete(to: length, with: element)
        return temp
    }
}
