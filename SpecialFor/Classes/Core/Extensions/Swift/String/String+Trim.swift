//
//  String+Trim.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/27/19.
//

extension String {
    public mutating func trim() {
        self = trimmed()
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
