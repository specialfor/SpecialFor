//
//  LoadableViewController.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/2/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//
//

import UIKit
import SnapKit

public protocol AnyLoadable {
    func showLoader()
    func showLoader(props: AnyProps)
    
    func hideLoader()
}

public protocol Loadable: AnyLoadable {
    associatedtype View: Renderable
    func showLoader(props: View.Props)
}

public extension Loadable {
    func showLoader(props: AnyProps) {
        showLoader(props: props as! View.Props)
    }
}

extension Loadable where Self: UIViewController, View: UIView {
    private var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    private var loaderView: View? {
        return window?.subviews.first(where: { $0 is View }) as? View
    }
    
    func showLoader() {
        showLoader(props: .initial)
    }
    
    func showLoader(props: View.Props) {
        guard let window = window, self.loaderView == nil else {
            return
        }
        
        let loaderView = View()
        loaderView.alpha = 0
        
        window.addSubview(loaderView)
        loaderView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        loaderView.render(props: props)
        
        UIView.animate(withDuration: 0.3) {
            loaderView.alpha = 1.0
        }
    }
    
    func hideLoader() {
        guard let loaderView = self.loaderView else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            loaderView.alpha = 0.0
        }) { isFinished in
            guard isFinished else {
                return
            }
            
            loaderView.removeFromSuperview()
        }
    }
}
