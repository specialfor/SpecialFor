//
//  FloatingPlaceholderProvider.swift
//  TestTextFields
//
//  Created by Volodymyr Hryhoriev on 5/5/18.
//  Copyright © 2018 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

public enum FloatingState {
    case collapsed
    case `default`
}

public protocol FloatingPlaceholderProvider: class {
    var placeholderCollapsedFontSize: CGFloat { get set }
    var placeholderFont: UIFont { get set }
    
    var placeholder: String? { get set }
    var placeholderColor: UIColor { get set }
    
    var floatingState: FloatingState { get set }
    
    func updateFloatingState(_ state: FloatingState, animated: Bool)
}
