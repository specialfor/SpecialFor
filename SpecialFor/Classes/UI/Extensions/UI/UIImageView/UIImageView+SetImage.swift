//
//  UIImageView+SetImage.swift
//  Nynja
//
//  Created by Anton Makarov on 27.11.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    typealias DownloadCompletion = (URL?, UIImage?, Error?) -> Void
    
    struct DownloadOptions: OptionSet {
        let rawValue: Int
        
        init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static let delayPlaceholder = DownloadOptions(rawValue: 1 << 0)
        
        fileprivate var sdWebImageOptions: SDWebImageOptions {
            var options: SDWebImageOptions = []
            
            if contains(.delayPlaceholder) {
                options.formUnion(.delayPlaceholder)
            }
            
            return options
        }
    }
    
    func setImage(url: URL?,
                  placeHolder: UIImage? = nil,
                  options: DownloadOptions = [],
                  accessibilityPrefix: String? = nil,
                  completion: DownloadCompletion? = nil) {
        
        setInitialAccesibilityIdentifier(accessibilityPrefix: accessibilityPrefix)
        
        if let localURL = url, localURL.isLocalURL {
            image = UIImage(fileUrl: localURL)
            
            setLoadedAccesibilityIdentifier(accessibilityPrefix: accessibilityPrefix)
            completion?(url, image, nil)
            
        } else {
            if options.contains(.delayPlaceholder), image == nil {
                image = placeHolder
            }            
            sd_setImage(with: url, placeholderImage: placeHolder, options: options.sdWebImageOptions) {
                [weak self] image, error, cache, url in
                
                if error == nil, image != nil {
                    self?.setLoadedAccesibilityIdentifier(accessibilityPrefix: accessibilityPrefix)
                }
                completion?(url, image, error)
            }
        }
    }

    private func setInitialAccesibilityIdentifier(accessibilityPrefix: String?) {
        accessibilityIdentifier = (accessibilityPrefix ?? "") + "_" + "placeholder_image"
    }

    private func setLoadedAccesibilityIdentifier(accessibilityPrefix: String?) {
        accessibilityIdentifier = (accessibilityPrefix ?? "") + "_" + "loaded_image"
    }
}
