//
//  TopSwipable.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 2/14/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

typealias TopSwipeAction = () -> Void

protocol TopSwipable: class {
    
    var recognizer: GestureRecognizerClosure<LongPressWithUpSwipeGestureRecognizer>! { get set }
    
    var shouldBeginAction: (() -> Bool)? { get set }
    var beginAction: TopSwipeAction? { get set }
    var swipeAction: TopSwipeAction? { get set }
    var cancelAction: TopSwipeAction? { get set }
    
    func setup()
}

extension TopSwipable where Self: UIView {
    
    func setup() {
        isUserInteractionEnabled = true
        
        guard recognizer == nil else {
            return
        }
        recognizer = GestureRecognizerClosure<LongPressWithUpSwipeGestureRecognizer> { [weak self] recognizer in
            let shouldBegin = self?.shouldBeginAction?() ?? true
            guard shouldBegin == true else { return }

            switch recognizer.state {
            case .began:
                self?.beginAction?()
            case .ended:
                self?.swipeAction?()
            case .failed, .cancelled:
                self?.cancelAction?()
            default:
                break
            }
        }
        addGestureRecognizer(recognizer.recognizer)
    }
}

final class GestureRecognizerClosure<Recognizer: UIGestureRecognizer> {
    typealias RecognizerAction = (Recognizer) -> Void
    
    let recognizer: Recognizer
    let action: RecognizerAction
    
    init(action: @escaping RecognizerAction) {
        self.action = action
        self.recognizer = Recognizer()
        self.recognizer.addTarget(self, action: #selector(fired(_:)))
    }
    
    @objc private func fired(_ recognizer: UIGestureRecognizer) {
        self.action(recognizer as! Recognizer)
    }
}
