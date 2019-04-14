//
//  Renderable.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2018 Specialfor. All rights reserved.
//

public protocol AnyRenderable: AnyObject {
    func render(props: AnyProps)
}

public protocol Renderable: AnyRenderable {
    associatedtype Props: TypedProps
    
    func render(props: Props)
}

public extension Renderable {
    func render(props: AnyProps) {
        render(props: props as! Props)
    }
}

public protocol AnyProps {
    static var initial: AnyProps { get }
}

public protocol TypedProps: AnyProps {
    static var initial: Self { get }
}

public extension TypedProps {
    static var initial: AnyProps {
        return initial
    }
}
