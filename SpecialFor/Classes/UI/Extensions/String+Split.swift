//
//  String+Split.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 22.08.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

protocol StringInitializable {
    init?(_ string: String)
}

extension Int64: StringInitializable { }

extension String {
    func splitByComma<T: StringInitializable>(_ type: T.Type) -> [T]? {
        return components(separatedBy: ",").compactMap(T.init)
    }
    
    func splitByComma<T>(transform: (String) -> T?) -> [T]? {
        return components(separatedBy: ",").compactMap(transform)
    }
    
    func splitByComma() -> [String] {
        return components(separatedBy: ",")
    }
    
    func splitIntegerIdentifiers() -> [AnyObject]? {
        return splitByComma(Int64.self) as [AnyObject]?
    }
    
    func split(by length: Int) -> [String] {
        var startIndex = self.startIndex
        var results = [Substring]()
        
        while startIndex < self.endIndex {
            let endIndex = self.index(startIndex, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            results.append(self[startIndex..<endIndex])
            startIndex = endIndex
        }
        
        return results.map { String($0) }
    }
}
