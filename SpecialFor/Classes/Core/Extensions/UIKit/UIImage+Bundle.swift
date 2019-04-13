//
//  UIImage+Bundle.swift
//  Example
//
//  Created by Volodymyr Hryhoriev on 4/13/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init?<T: AnyObject>(named: String, token: T.Type) {
        let bundle = Bundle(for: token)
        self.init(named: named, in: bundle, compatibleWith: nil)
    }
}
