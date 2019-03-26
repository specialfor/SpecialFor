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
    var resolution: CGSize {
        guard let source = CGImageSourceCreateWithURL(self as CFURL, nil),
            let header = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: AnyObject],
            let width = header["PixelWidth"] as? CGFloat,
            let height = header["PixelHeight"] as? CGFloat else {
                return .zero
        }

        return CGSize(width: width, height: height)
    }

    var isLocalURL: Bool {
        return isFileURL || absoluteString.contains("/var/mobile/Containers/Data/Application")
    }
}
