//
//  Sequence+MaxExcept.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 9/27/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension Sequence where Element: Comparable & Hashable {
    
    /// Returns max element in sequence except `element` one.
    /// If sequence contains only `element`, return `element`.
    public func max(except element: Element) -> Element {
        var set = Set<Element>(self)
        set.remove(element)
        return set.max() ?? element
    }
}
