//
//  WeakRef.swift
//  Nynja
//
//  Created by Sergey Lomov on 12/13/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//
import Foundation

public class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?
    
    public init(value: T?) {
        self.value = value
    }
}

public class AnyWeakSubscriber<Handler> {
    public let object: WeakRef<AnyObject>
    public let handler: Handler
    
    public init(object: AnyObject, handler: Handler) {
        self.object = WeakRef(value: object)
        self.handler = handler
    }
}
