//
//  EmptyStateViewModel.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 5/31/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

public struct EmptyStateViewModel {
    public let image: UIImage?
    public let descriptionText: String
    
    public let actionViewModel: ActionViewModel?
    
    public init(image: UIImage?, descriptionText: String, actionViewModel: ActionViewModel? = nil) {
        self.image = image
        self.descriptionText = descriptionText
        self.actionViewModel = actionViewModel
    }
}


// MARK: - ActionViewModel

extension EmptyStateViewModel {
    
    public struct ActionViewModel {
        public let title: String
        public let handler: Closure?

        public init(title: String, handler: Closure?) {
            self.title = title
            self.handler = handler
        }
    }
}
