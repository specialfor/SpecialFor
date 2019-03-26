//
//  Array+Extensions.swift
//  Nynja
//
//  Created by Anton Makarov on 24.10.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//


// MARK: - Remove

extension Array where Element: Equatable {
    
    mutating func remove(_ element: Element) {
        guard let index = index(of: element) else {
            return
        }
        remove(at: index)
    }
    
    mutating func remove(at indexes: [Index]) {
        indexes.sorted(by: >).forEach { remove(at: $0) }
    }
}

extension Array {
    
    // MARK: - Count

    func count(where predicate: (Element) -> Bool) -> Int {
        var count = 0
        for element in self where predicate(element) {
            count += 1
        }
        return count
    }
    
    
    // MARK: - Move
    
    mutating func move(at index: Int, to newIndex: Int) {
        let element = remove(at: index)
        insert(element, at: newIndex)
    }
    
    
    // MARK: - Complete
    
    mutating func complete(to length: Int, with element: Element) {
        guard self.count <= length else {
            return
        }
        
        for _ in self.count..<length {
            self.append(element)
        }
    }
    
    func completed(to length: Int, with element: Element) -> [Element] {
        var temp = self
        temp.complete(to: length, with: element)
        return temp
    }
    
    
    // MARK: - Filter
    
    func filter(with text: String, predicate: (Element) -> [String]) -> [Element] {
        var filtered = self
        
        if !text.isEmpty {
            filtered = filter { element in
                let strings = predicate(element)
                guard !strings.isEmpty else {
                    return false
                }
                return text.isIn(strings: strings, options: .caseInsensitive)
            }
        }
        
        return filtered
    }
}
