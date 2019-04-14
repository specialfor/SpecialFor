//
//  BannerWindow.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import SnapKit

public final class BannerWindow: UIWindow {
    
    public var duration: TimeInterval = 0.3
    public var delay: TimeInterval = 3.0
    
    public let height: CGFloat = 20.0
    
    private var rect: CGRect {
        let topInset: CGFloat
        if #available(iOS 11.0, *) {
            topInset = safeAreaInsets.top > 0 ? safeAreaInsets.top - 14.0 : 0
        } else {
            topInset = 0
        }
        
        let totalHeight = topInset + height
        
        return CGRect(x: 0, y: -totalHeight, width: UIScreen.main.bounds.width, height: totalHeight)
    }
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        return label
    }()
    
    // MARK: - Show
    
    public func show(title: String) {
        guard isHidden else {
            return
        }
        
        isHidden.toggle()
        windowLevel = .statusBar
        frame = rect
        titleLabel.text = title
        
        let yOffset = rect.height
        UIView.animate(withDuration: duration, animations: {
            self.frame.origin.y += yOffset
        }) { _ in
            UIView.animate(withDuration: self.duration, delay: self.delay, options: [], animations: {
                self.frame.origin.y -= yOffset
            }) { _ in
                self.isHidden.toggle()
            }
        }
    }
}
