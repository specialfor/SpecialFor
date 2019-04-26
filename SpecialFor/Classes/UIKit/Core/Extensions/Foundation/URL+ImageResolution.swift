//
//  URLExtensions.swift
//  Nynja
//
//  Created by Anton Makarov on 21.11.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import ImageIO

extension URL {
    public var imageResolution: CGSize? {
        guard let source = CGImageSourceCreateWithURL(self as CFURL, nil),
            let header = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: AnyObject],
            let width = header["PixelWidth"] as? CGFloat,
            let height = header["PixelHeight"] as? CGFloat else {
                return nil
        }

        return CGSize(width: width, height: height)
    }
}
