//
//  TableViewManager.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import CellViewModel

public final class TableViewManager: NSObject, UITableViewDataSource {
    public typealias Models = [AnyCellViewModel]
    
    let tableView: UITableView
    
    public var models: Models = [] {
        didSet { reloadData() }
    }
    
    public init(tableView: UITableView, models: Models = []) {
        self.tableView = tableView
        self.models = models
        
        super.init()
        
        tableView.dataSource = self
        reloadData()
    }
    
    private func reloadData() {
        models.forEach { tableView.register(type(of: $0)) }
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        return tableView.dequeueReusableCell(with: model, for: indexPath)
    }
}
