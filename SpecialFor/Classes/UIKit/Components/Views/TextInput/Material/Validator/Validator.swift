//
//  Validator.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/26/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

public protocol MTIValidator {
    func validate(text: String) -> InputInfo?
}
