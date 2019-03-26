//
//  FastScrollable.swift
//  Nynja
//
//  Created by Anton Poltoratskyi on 06.03.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import UIKit

protocol FastScrollable: class {
    var scrollBar: ScrollBar? { get }
    var scrollOffset: CGFloat { get set }
    
    func fastScrollTitle(for section: Int, in tableView: UITableView) -> String?
    func handleFastScroll(in tableView: UITableView)
}

extension FastScrollable {
    
    func handleFastScroll(in tableView: UITableView) {
        let offset = tableView.contentOffset.y
        
        let isBottom = scrollOffset - offset < 0
        let isTop = scrollOffset - offset > 0
        
        self.scrollOffset = offset
        
        let cells = tableView.visibleCells
        guard !cells.isEmpty else {
            return
        }
        
        if isTop {
            if let beginSection = tableView.indexPath(for: cells.first!)?.section {
                setupFastScrollLabel(for: beginSection, in: tableView)
            }
        } else if isBottom {
            if let endSection = tableView.indexPath(for: cells.last!)?.section {
                setupFastScrollLabel(for: endSection, in: tableView)
            }
        }
    }
    
    private func setupFastScrollLabel(for section: Int, in tableView: UITableView) {
        guard let bar = scrollBar, !bar.isOnUpdate else { return }
        scrollBar?.infoView.titleLabel.text = fastScrollTitle(for: section, in: tableView)
    }
}
