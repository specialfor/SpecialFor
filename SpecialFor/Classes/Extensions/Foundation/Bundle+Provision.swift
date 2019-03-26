//
//  Bundle+Provision.swift
//  Nynja
//
//  Created by Anton M on 08.08.2018.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import Foundation

extension Bundle {
    
    enum BuildType {
        case developer
        case adHoc
        case appStore
        case simulator
        
        func getAPNS() -> String {
            switch self {
            case .adHoc, .appStore:
                return "LIVE"
            case .developer, .simulator:
                return "SANDBOX"
            }
        }
    }
    
    static func getProvisionType() -> BuildType {
        #if IOS_SIMULATOR
            return .simulator
        #else
        // there will be no provisioning profile in AppStore Apps
        guard let fileName = Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") else {
            return .appStore
        }
        
        let fileURL = URL(fileURLWithPath: fileName)
        // the documentation says this file is in UTF-8, but that failed
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
