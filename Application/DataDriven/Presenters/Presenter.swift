//
//  Presenter.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

public protocol Presenter {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func keyboardWillShow()
}

public extension Presenter {
    func viewWillAppear() {}
    func viewDidAppear() {}
    func keyboardWillShow() {}
}
