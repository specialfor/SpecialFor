//
//  Injectable.swift
//  Nynja
//
//  Created by AshCenso on 5/14/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import Foundation

public protocol Injectable {
    associatedtype Dependencies
}

public protocol InitializeInjectable: Injectable {
    init(dependencies: Dependencies)
}

public protocol SetInjectable: Injectable {
    func inject(dependencies: Dependencies)
}
