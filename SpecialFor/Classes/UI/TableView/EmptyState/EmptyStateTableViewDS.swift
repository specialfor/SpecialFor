//
//  EmptyStateTableViewDS.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/7/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

class EmptyStateTableViewDS: TableViewDataSourceProxy {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        
        view.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.greaterThanOrEqualToSuperview().inset(16.0)
        }
        
        return view
    }()
    
    private let emptyStateView: EmptyStateView = EmptyStateView()
    
    var emptyStateViewModel: EmptyStateViewModel?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sections = super.numberOfSections(in: tableView)
        
        let shouldShow = sections == 0
        toggleBackgroundViewIfNeeded(in: tableView, shouldShow: shouldShow)
        
        return sections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = super.tableView(tableView, numberOfRowsInSection: section)
        let sections = numberOfSections(in: tableView)
        
        let shouldShow = sections == 1 && rows == 0
        toggleBackgroundViewIfNeeded(in: tableView, shouldShow: shouldShow)
        
        return rows
    }
    
    private func toggleBackgroundViewIfNeeded(in tableView: UITableView, shouldShow: Bool) {
        guard shouldShow else {
            tableView.backgroundView = nil
            return
        }
        
        if let viewModel = emptyStateViewModel {
            emptyStateView.setup(with: viewModel)
            tableView.backgroundView = backgroundView
        } else {
            tableView.backgroundView = nil
        }
    }
}
