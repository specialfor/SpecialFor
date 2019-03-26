//
//  InputInfo.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

struct InputInfo {
    
    enum Kind {
        case warning
        case success
    }
    
    let text: String
    let kind: Kind
}
