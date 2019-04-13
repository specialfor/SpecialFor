//
//  UIImageView+Environment.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/5/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init?(_ named: String, environment: Environment? = AppEnvironment.current) {
        self.init(named: named, in: environment?.bundle, compatibleWith: nil)
    }
}
