//
//  LoaderView.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 4/2/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import SnapKit
import SwiftGifOrigin

public final class GifLoaderView: View, Renderable {
    public override var activatedViews: [UIView] {
        return [overlayView, gifView]
    }

    public var overlayBackgroundColor: UIColor?  {
        didSet { overlayView.backgroundColor = overlayBackgroundColor }
    }
    
    // MARK: - Subviews
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var gifView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24.0)
            make.centerY.equalToSuperview()
        }
        
        return imageView
    }()
    
    // MARK: - UIView
    
    public override func baseSetup() {
        super.baseSetup()
        backgroundColor = .clear
    }
    
    // MARK: - Renderable
    
    public func render(props: Props) {
        overlayView.isHidden = !props.usingOverlay
        
        gifView.loadGif(name: props.gifName)
    }
}

extension GifLoaderView {
    public struct Props: TypedProps {
        public let usingOverlay: Bool
        public let gifName: String
        
        public init(usingOverlay: Bool, gifName: String) {
            self.usingOverlay = usingOverlay
            self.gifName = gifName
        }
        
        public static let initial = Props(usingOverlay: true, gifName: "")
    }
}
