//
//  Collections+SafeSubscript.swift
//  Nynja
//
//  Created by Anton M on 26.04.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension Collection {
    public subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
