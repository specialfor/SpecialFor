//
//  CollectionState.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 6/7/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

enum CollectionState<Input> {
    case empty(EmptyStateViewModel?)
    case filled(data: Input)
}
