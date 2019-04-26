//
//  UIImage+Extension.swift
//  Nynja
//
//  Created by Anton Makarov on 28.08.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init?(fileUrl: URL) {
        guard let data = try? Data(contentsOf: fileUrl, options: .uncached) else {
            return nil
        }
        
        self.init(data: data, scale: UIScreen.main.scale)
    }
    
    convenience init?(color: UIColor, size: CGSize) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func cropping(to rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage,
            let imageRef = cgImage.cropping(to: rect) else {
                return nil
        }

        return UIImage(cgImage: imageRef)
    }
}
