//
//  URLExtensions.swift
//  Nynja
//
//  Created by Anton Makarov on 21.11.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import ImageIO

extension URL {
    func getResolution() -> CGSize? {
        if let source = CGImageSourceCreateWithURL(self as CFURL, nil), let header = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: AnyObject] {
            if let width = header["PixelWidth"] as? CGFloat, let height = header["PixelHeight"] as? CGFloat {
                return CGSize(width: width, height: height)
            }
        }
        return nil
    }

    var isLocalURL: Bool {
        return isFileURL || absoluteString.contains("/var/mobile/Containers/Data/Application")
    }
    
    var thumbUrl: URL? {
        let fileName = String(self.lastPathComponent)
        guard let path = FileManagerService.sharedInstance.getPathOfFile(folder: FileManagerService.Folders.thumb.rawValue, name: fileName) else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
    
    var mediaURL: URL? {
        let fileName = String(self.lastPathComponent)
        guard let path = FileManagerService.sharedInstance.getPathOfFile(folder: FileManagerService.Folders.downloads.rawValue, name: fileName) else {
            return nil
        }
        return URL(fileURLWithPath: path)
    }
}
