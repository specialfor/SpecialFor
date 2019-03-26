//
//  Injectable.swift
//  Nynja
//
//  Created by AshCenso on 5/14/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import Foundation

protocol Injectable {
    associatedtype Dependencies
}

protocol InitializeInjectable: Injectable {
    init(dependencies: Dependencies)
}

protocol SetInjectable: Injectable {
    func inject(dependencies: Dependencies)
}
