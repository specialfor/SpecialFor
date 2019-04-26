//
//  PHAsset+Extension.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 1/9/19.
//  Copyright © 2019 TecSynt Solutions. All rights reserved.
//

import Photos

extension PHAsset {
    public var fileSize: Int64 {
        return valueFromResource(forKey: "fileSize", defaultValue: 0)
    }
    
    public var resolution: CGSize {
        return CGSize(width: pixelWidth, height: pixelHeight)
    }
    
    private func valueFromResource<T>(forKey key: String) -> T? {
        let resources = PHAssetResource.assetResources(for: self)
        return resources.first.flatMap { $0.value(forKey: key) as? T }
    }
    
    private func valueFromResource<T>(forKey key: String, defaultValue: @autoclosure () -> T) -> T {
        guard let value: T = valueFromResource(forKey: key) else {
            return defaultValue()
        }
        
        return value
    }
}
