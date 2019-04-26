//
//  InputInfo.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

public struct InputInfo {
    public enum Kind {
        case warning
        case success
    }
    
    public let text: String
    public let kind: Kind

    public init(text: String, kind: Kind) {
        self.text = text
        self.kind = kind
    }
}
