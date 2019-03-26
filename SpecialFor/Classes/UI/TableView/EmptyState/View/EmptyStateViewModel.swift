//
//  EmptyStateViewModel.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/31/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

struct EmptyStateViewModel {
    let image: UIImage?
    let descriptionText: String
    
    let actionViewModel: ActionViewModel?
    
    init(image: UIImage?, descriptionText: String, actionViewModel: ActionViewModel? = nil) {
        self.image = image
        self.descriptionText = descriptionText
        self.actionViewModel = actionViewModel
    }
}


// MARK: - ActionViewModel

extension EmptyStateViewModel {
    
    struct ActionViewModel {
        let title: String
        let handler: EmptyStateView.ActionHandler?
    }
}
