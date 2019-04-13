//
//  TextField.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/2/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

/// Defines which items in clipboard should be prohibited (not visible and allowed)
public struct ProhibitedOptions: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let none                     = ProhibitedOptions(rawValue: 0)
    static let copy                     = ProhibitedOptions(rawValue: 1 << 0)
    static let paste                    = ProhibitedOptions(rawValue: 1 << 1)
    static let all: ProhibitedOptions   = ProhibitedOptions(rawValue: Int.max)
}

open class TextField: UITextField {
    
    /// Determines which options are prohibited
    /// Default: .none
    public var prohibitedOptions: ProhibitedOptions = .none
    
    /// Determines that `text` of `UITextField` should be reseted,
    /// when app enters background
    /// Default: false
    public var shouldResetAfterBackground: Bool = false {
        willSet {
            if newValue != shouldResetAfterBackground {
                toggleSubscription(newValue)
            }
        }
    }
    
    /// Holds action which will be executed after text resets
    public var didResetHandler: (() -> Void)?
    
    /// Set as `text` if `shouldResetAfterBackground` is true
    /// and app enters bakcground
    public var initialText: String?
    
    
    // MARK: - Deinit
    
    deinit {
        if shouldResetAfterBackground {
            unscribeFromBackgroundNotification()
        }
    }
    
    
    // MARK: - Handle clipboard actions (prohibited options)
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if prohibitedOptions == .all {
            return false
        }
        
        if prohibitedOptions.contains(.copy) {
            return action != #selector(copy(_:))
        }
        
        if prohibitedOptions.contains(.paste) {
            return action != #selector(paste(_:))
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
    
    
    // MARK: - Clear in background
    
    private func toggleSubscription(_ shouldSubscribe: Bool) {
        if shouldSubscribe {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(handleBackgroundNotification),
                                                   name: UIApplication.didEnterBackgroundNotification,
                                                   object: nil)
        } else {
            unscribeFromBackgroundNotification()
        }
    }
    
    private func unscribeFromBackgroundNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didEnterBackgroundNotification,
                                                  object: nil)
    }
    
    @objc private func handleBackgroundNotification() {
        text = initialText
        selectedTextRange = textRange(from: beginningOfDocument, to: beginningOfDocument)
        didResetHandler?()
    }
}
