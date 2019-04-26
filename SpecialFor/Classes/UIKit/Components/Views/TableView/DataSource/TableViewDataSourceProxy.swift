//
//  TableViewDataSourceProxy.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/6/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

open class TableViewDataSourceProxy: NSObject, UITableViewDataSource {
    public let dataSource: UITableViewDataSource
    
    public init(dataSource: UITableViewDataSource) {
        self.dataSource = dataSource
    }
    
    // MARK: - UITableViewDataSource
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.numberOfSections?(in: tableView) ?? 1
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource.tableView?(tableView, titleForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return dataSource.tableView?(tableView, titleForFooterInSection: section)
    }

    open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource.tableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    
    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return dataSource.tableView?(tableView, canMoveRowAt: indexPath) ?? false
    }

    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSource.sectionIndexTitles?(for: tableView)
    }

    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return dataSource.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? 0
    }

    open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataSource.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }

    open func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
}
