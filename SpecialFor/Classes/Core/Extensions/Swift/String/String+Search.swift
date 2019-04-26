//
//  String+Search.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension String {
    public func isIn(string: String, options: String.CompareOptions) -> Bool {
        return string.contains(substring: self, options: options)
    }
    
    public func isIn(strings: [String], options: String.CompareOptions) -> Bool {
        return strings.contains(substring: self, options: options)
    }
    
    public func contains(substring: String, options: String.CompareOptions) -> Bool {
        return range(of: substring, options: options) != nil
    }
}

extension Array where Element == String {
    public func contains(substring: String, options: String.CompareOptions) -> Bool {
        return contains { $0.contains(substring: substring, options: options) }
    }
    
    public func filter(with text: String, predicate: (Element) -> [String]) -> [Element] {
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
