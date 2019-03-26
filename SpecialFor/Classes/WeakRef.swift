//
//  WeakRef.swift
//  Nynja
//
//  Created by Sergey Lomov on 12/13/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//
import Foundation

class WeakRef<T> where T: AnyObject {
    
    private(set) weak var value: T?
    
    init(value: T?) {
        self.value = value
    }
}

class AnyWeakSubscriber<Handler> {
    let object: WeakRef<AnyObject>
    let handler: Handler
    
    init(object: AnyObject, handler: Handler) {
        self.object = WeakRef(value: object)
        self.handler = handler
    }
}
