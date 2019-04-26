//
//  String+Contains.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//

extension String {
    public func containsOnly(characters: String) -> Bool {
        let cs = CharacterSet(charactersIn: characters).inverted
        let filtered = self.components(separatedBy: cs).joined(separator: "")
        return self == filtered
    }
}
