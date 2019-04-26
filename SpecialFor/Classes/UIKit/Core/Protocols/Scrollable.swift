//
//  Scrollable.swift
//  Glypher
//
//  Created by Volodymyr Hryhoriev on 3/5/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import CoreGraphics

public protocol Scrollable {
    var scrollInfo: Scroll.Info { get }
}

public enum Scroll {
    public enum Position {
        case atTop
        case atBottom
        case inProgress
    }
    
    public struct Info {
        public let position: Position
        public let offset: CGFloat

        public init(position: Position, offset: CGFloat) {
            self.position = position
            self.offset = offset
        }
    }
}

// MARK: - UIScrollView

extension UIScrollView: Scrollable {
    public var scrollInfo: Scroll.Info {
        let position: Scroll.Position
        let offset = contentOffset.y
        
        if offset <= 0 {
            position = .atTop
        } else if offset >= contentSize.height {
            position = .atBottom
        } else {
            position = .inProgress
        }
        
        return .init(position: position, offset: offset)
    }
    
    public var position: Scroll.Position {
        return scrollInfo.position
    }
}
