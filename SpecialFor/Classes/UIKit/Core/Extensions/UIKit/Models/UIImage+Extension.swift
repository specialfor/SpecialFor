//
//  UIImage+Extension.swift
//  Nynja
//
//  Created by Anton Makarov on 28.08.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init?(fileUrl: URL) {
        guard let data = try? Data(contentsOf: fileUrl, options: .uncached) else {
            return nil
        }
        
        self.init(data: data, scale: UIScreen.main.scale)
    }
    
    public static func imageWithColor(color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        color.setFill()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    public func imageByTintColor(color: UIColor) -> UIImage? {
        let size = self.size
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        color.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(rect)
        
        draw(at: CGPoint(x: 0, y: 0), blendMode: .destinationIn, alpha: 1)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    public func cropping(to rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage,
            let imageRef = cgImage.cropping(to: rect) else {
                return nil
        }

        return UIImage(cgImage: imageRef)
    }
}
