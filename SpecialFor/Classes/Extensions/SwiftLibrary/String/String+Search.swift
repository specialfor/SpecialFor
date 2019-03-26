//
//  String+Search.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension String {
    
    func isIn(string: String, options: String.CompareOptions) -> Bool {
        return string.contains(substring: self, options: options)
    }
    
    func isIn(strings: [String], options: String.CompareOptions) -> Bool {
        return strings.contains(substring: self, options: options)
    }
    
    func contains(substring: String, options: String.CompareOptions) -> Bool {
        return range(of: substring, options: options) != nil
    }
}

extension Array where Element == String {
    
    func contains(substring: String, options: String.CompareOptions) -> Bool {
        return contains { $0.contains(substring: substring, options: options) }
    }
}
