//
//  Bundle+Provision.swift
//  Nynja
//
//  Created by Anton M on 08.08.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import Foundation

extension Bundle {
    
    public enum BuildType {
        case developer
        case adHoc
        case appStore
        case simulator
    }
    
    public static var provisionType: BuildType {
        #if targetEnvironment(simulator)
        return .simulator
        #else
        
        // There will be no provisioning profile in AppStore Apps
        guard let fileName = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") else {
            return .appStore
        }
        
        let fileURL = URL(fileURLWithPath: fileName)
        
        // The documentation says this file is in UTF-8, but that failed
        // on my machine. ASCII encoding worked ¯\_(ツ)_/¯
        guard let data = try? String(contentsOf: fileURL, encoding: .ascii) else {
            return .adHoc
        }
        
        let cleared: String = data.components(separatedBy: .whitespacesAndNewlines).joined()
        if cleared.contains("<key>get-task-allow</key><true/>") {
            return .developer
        }
        return .adHoc
        #endif
    }
}
