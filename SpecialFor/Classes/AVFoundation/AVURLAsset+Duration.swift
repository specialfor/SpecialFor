//
//  AVURLAsset+Duration.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 1/4/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import AVFoundation.AVAsset

extension AVURLAsset {
    public static func duration(from url: URL) -> Double {
        let asset = AVURLAsset(url: url, options: nil)
        return CMTimeGetSeconds(asset.duration)
    }
}
