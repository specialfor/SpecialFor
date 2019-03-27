//
//  String+CapitalizeFirstLetter.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/27/19.
//

extension String {
    
    public func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
