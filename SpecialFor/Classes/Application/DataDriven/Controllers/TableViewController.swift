//
//  TableViewController.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import UIKit

// TODO: need to remove and implement swizling.
public class TableViewController: UITableViewController {
    public var presenter: Presenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}
