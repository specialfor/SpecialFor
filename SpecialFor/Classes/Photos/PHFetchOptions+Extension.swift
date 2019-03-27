//
//  PHFetchOptions+Extension.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/19/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import Photos

extension PHFetchOptions {
    
    public convenience init(sortedByCreationDateOrder isAscending: Bool) {
        self.init()
        self.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: isAscending)]
    }
}
