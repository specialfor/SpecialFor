//
//  Coordinator.swift
//  Nenno's Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var coordinators: [Coordinator] { get set }
    
    func start()
    func prepareToEnd()
}

public extension Coordinator {
    func show(_ coordinator: Coordinator) {
        coordinator.parent = self
        coordinators.append(coordinator)
        coordinator.start()
    }
    
    func hide(_ coordinator: Coordinator) {
        guard coordinator.parent === self else {
            return
        }
        coordinator.end()
    }
    
    func end() {
        prepareToEnd()
        parent?.coordinators.removeAll(where: { $0 === self })
        parent = nil
    }
    
    func prepareToEnd() {}
}
