//
//  UIImageExtensions.swift
//  Nynja
//
//  Created by Anton Makarov on 28.08.2017.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

/* - (UIImage *)imageByTintColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
} */

extension UIImage {
    
    var scaledSize: CGSize {
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    convenience init?(fileUrl: URL) {
        guard let data = try? Data(contentsOf: fileUrl, options: .uncached) else {
            return nil
        }
        self.init(data: data, scale: UIScreen.main.scale)
    }
    
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    func imageByTintColor(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        color.set()
        UIRectFill(rect)
        
        self.draw(at: CGPoint(x: 0, y: 0), blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func heightForWidth(width: CGFloat, imageSize: CGSize? = nil) -> CGFloat {
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: width,
                                  height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: imageSize ?? size,
                               insideRect: boundingRect)
        return rect.size.height
    }
    
    func widthForHeight(height: CGFloat, imageSize: CGSize? = nil) -> CGFloat {
        let boundingRect = CGRect(x: 0,
                                  y: 0,
                                  width: CGFloat(MAXFLOAT),
                                  height: height)
        let rect  = AVMakeRect(aspectRatio: imageSize ?? size,
                               insideRect: boundingRect)
        return rect.size.width
    }
    
    func fixedOrientation() -> UIImage
    {
        if imageOrientation == .up {
            return self
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
            break
        case .up, .upMirrored:
            break
        }
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    func resizeImage(targetSize: CGSize, scale: CGFloat? = nil) -> UIImage {
        let size = self.size
        let scale = scale ?? self.scale
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height:  size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }

    func rotatedImage() -> UIImage {
        guard let imageRef = cgImage else {
            return self
        }

        switch imageOrientation {
        case .up: return self
        case .down: return UIImage(cgImage: imageRef, scale: 1, orientation: .down)
        case .right:
            UIGraphicsBeginImageContext(size)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return img ?? self
        default: return self
        }
    }

    func scale(_ scale: CGFloat) -> UIImage {
        let targetSize = CGSize(width: size.width * scale, height: size.height * scale)

        return resizeImage(targetSize: targetSize)
    }

    func compressTo(_ expectedSizeInKb: Int) -> Data? {
        let sizeInBytes = expectedSizeInKb * 1024

        var needCompress: Bool = true
        var imgData: Data?

        var compressingValue:CGFloat = 1.0

        while (needCompress && compressingValue > 0.0) {
            if let data = jpegData(compressionQuality: compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }

        if let data = imgData {
            if (data.count < sizeInBytes) {
                return data
            }
        }
        
        return nil
    }

    func croppedImage(rect: CGRect) -> UIImage? {
        guard let cgImage = cgImage,
            let imageRef = cgImage.cropping(to: rect) else {
                return nil
        }

        let croppedImage = UIImage(cgImage: imageRef)

        return croppedImage
    }
}
