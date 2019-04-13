//
//  UIVIew+Constraint.swift
//  NennosPizza
//
//  Created by Volodymyr Hryhoriev on 4/9/19.
//  Copyright © 2019 Alessio Bonu. All rights reserved.
//

import UIKit

extension UIView {
    public func makeCosntraints(_ closure: () -> [NSLayoutConstraint]) {
        let constraints = closure()
        makeConstraints(constraints)
    }
    
    private func makeConstraints(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { $0.isActive = true }
    }
    
    public func addSubview(_ view: UIView, constraintsMaker: (UIView) -> [NSLayoutConstraint]) {
        addSubview(view)
        let constraints = constraintsMaker(self)
        view.makeConstraints(constraints)
    }
    
    public func edgesConstraints(to view: UIView) -> [NSLayoutConstraint] {
        return [
            verticalInsets(to: view),
            horizontalInsets(to: view),
            ].flatMap { $0 }
    }
    
    public func verticalInsets(to view: UIView, inset: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset),
        ]
    }
    
    public func horizontalInsets(to view: UIView, inset: CGFloat = 0) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset),
        ]
    }
    
    public func sizeConstraints(to view: UIView) -> [NSLayoutConstraint] {
        return [
            widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor),
        ]
    }
}
