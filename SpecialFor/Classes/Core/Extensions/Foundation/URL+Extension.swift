//
//  URL+Extension.swift
//  Pods-Example
//
//  Created by Volodymyr Hryhoriev on 3/26/19.
//

extension URL {
    
    public var isLocalURL: Bool {
        return isFileURL || absoluteString.contains("/var/mobile/Containers/Data/Application")
    }
}
