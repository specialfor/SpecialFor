//
//  PresenterWith.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

public protocol PresenterWith: Presenter {
    associatedtype View: Renderable
    
    var view: View? { get }
    func makeInitialProps() -> View.Props
    func loadData()
}

public extension PresenterWith {
    func viewDidLoad() {
        guard let view = view else {
            return
        }
        
        let props = makeInitialProps()
        view.render(props: props)
        loadData()
    }
    
    func loadData() {}
}
