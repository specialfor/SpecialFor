//
//  UITableViewExtensions.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 1/18/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

extension UITableView {
    
    static var `default`: UITableView {
        let tblView = UITableView()
        
        tblView.backgroundColor = UIColor.nynja.clear
        tblView.separatorStyle = .none
        tblView.tableFooterView = UIView()
        tblView.showsHorizontalScrollIndicator = false
        
        return tblView
    }
    
    func performUpdates(animated: Bool = true, _ closure: () -> Void) {
        if !animated {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
        }
        beginUpdates()
        closure()
        endUpdates()
        if !animated {
            CATransaction.commit()
        }
    }
    
    func disableAutomaticContentAdjustmentBahavior() {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }
    
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        })
        { _ in completion() }
    }
    
    func reloadVisibleCells(_ animation: UITableView.RowAnimation = .none) {
        if let visibleCellsIndex = self.indexPathsForVisibleRows {
            self.reloadRows(at: visibleCellsIndex, with: animation)
        }
    }
    
    func register<T: UITableViewCell>(_ type: T.Type) {
        let identifier = String(describing: type)
        self.register(type, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: type)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Type missmatch for cell")
        }
        
        return cell
    }
}
