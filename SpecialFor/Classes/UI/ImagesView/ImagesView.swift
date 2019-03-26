//
//  ImagesView.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 3/2/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

fileprivate let _spacing: Double = 4.0
fileprivate let _borderWidth: CGFloat = 2.0

class ImagesView: BaseView {
    enum ItemType {
        case url(URL?)
        case image(UIImage?)
    }
    
    var items: [ItemType] = [] {
        willSet {
            prevCountOfItems = items.count
        }
        didSet {
            reload()
        }
    }
    
    // MARK: - Geometry
    var size: CGSize = .zero {
        didSet {
            if oldValue != size {
                updateSizes()
            }
        }
    }
    
    var spacing: Double = _spacing.adjustedByWidth {
        didSet {
            if oldValue != spacing {
                updateSpacings()
            }
        }
    }
    
    // MARK: - Appearance
    var shouldShowBorder: Bool = true {
        didSet {
            if oldValue != shouldShowBorder {
                adjustBorders()
            }
        }
    }
    
    var borderColor: UIColor = UIColor.nynja.manatee {
        didSet {
            if oldValue != borderColor {
                adjustBorders()
            }
        }
    }
    
    var borderWidth: CGFloat = _borderWidth.adjustedByWidth {
        didSet {
            if oldValue != borderWidth {
                adjustBorders()
            }
        }
    }
    
    // MARK: - Private properties
    private var imageViews: [UIImageView] = [] {
        willSet {
            updateState(from: imageViews, to: newValue)
        }
    }
    private var leftConstraints: [Constraint] = []
    private var rightConstraint: Constraint?
    private var prevCountOfItems: Int = 0
    
    // MARK: - Reload
    private func updateState(from: [UIImageView], to: [UIImageView]) {
        let count = from.count
        let newCount = to.count
        
        let diff = newCount - count
        
        if diff != 0 {
            rightConstraint?.deactivate()
        }
        
        if diff > 0 {
            addNewViews(count: count, newCount: newCount, views: to)
        } else if diff < 0 {
            removeOldViews(count: count, newCount: newCount, views: from)
        }
    }
    
    private func addNewViews(count: Int, newCount: Int, views: [UIImageView]) {
        for index in count..<newCount {
            let imageView = views[index]
            
            imageView.setImage(with: items[index])
            self.addSubview(imageView)
            self.sendSubviewToBack(imageView)
            
            imageView.snp.makeConstraints { make in
                if index == 0 {
                    make.left.equalToSuperview()
                } else {
                    if index == items.count - 1 {
                        rightConstraint = make.right.equalToSuperview().priority(250).constraint
                    }
                    let constraint = make.left.equalTo(views[index - 1].snp.left).offset(spacing).constraint
                    leftConstraints.append(constraint)
                }
                
                make.top.bottom.equalToSuperview()
                make.size.equalTo(size)
            }
            
            adjustAlpha(for: imageView, index: index)
            adjustBorder(for: imageView)
            adjustCornerRadius(for: imageView)
        }
    }
    
    private func removeOldViews(count: Int, newCount: Int, views: [UIImageView]) {
        let slice = views[newCount..<count]
        slice.forEach { $0.removeFromSuperview() }
        
        let removeCount = count - newCount - 1
        leftConstraints.removeLast(removeCount)
        
        if newCount > 0 {
            views[newCount - 1].snp.makeConstraints { make in
                rightConstraint = make.right.equalToSuperview().priority(250).constraint
            }
        }
    }
    
    private func reload() {
        let diff = items.count - prevCountOfItems
        if diff > 0 {
            for _ in 0..<diff {
                imageViews.append(UIImageView())
            }
        } else if diff < 0 {
            imageViews.removeLast(-diff)
        } else {
            for (index, item) in items.enumerated() {
                imageViews[index].setImage(with: item)
            }
        }
    }
    
    // MARK: - Update constraints
    private func updateSpacings() {
        leftConstraints.forEach { $0.update(offset: spacing) }
    }
    
    private func updateSizes() {
        imageViews.forEach { imageView in
            imageView.snp.updateConstraints { $0.size.equalTo(size) }
        }
    }
    
    // MARK: - Adjust appearance
    private func alpha(for index: Int) -> CGFloat {
        let factor = 100.0 / CGFloat(items.count + 1)
        return (100.0 - factor * CGFloat(index)) / 100.0
    }
    
    private func adjustAlpha(for imageView: UIImageView, index: Int) {
        imageView.alpha = alpha(for: index)
    }
    
    private func adjustBorders() {
        imageViews.forEach { adjustBorder(for: $0) }
    }
    
    private func adjustBorder(for imageView: UIImageView) {
        if shouldShowBorder {
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = borderWidth
        } else {
            imageView.layer.borderColor = UIColor.nynja.clear.cgColor
            imageView.layer.borderWidth = 0.0
        }
    }
    
    private func adjustCornerRadius(for imageView: UIImageView) {
        imageView.clipsToBounds = true
        imageView.roundCorners(radius: size.height / 2)
    }
    
    private func adjustCornerRadiuses() {
        imageViews.forEach { adjustCornerRadius(for: $0) }
    }
    
}

extension UIImageView {
    
    func setImage(with type: ImagesView.ItemType) {
        let placeholder = UIImage.nynja.Contacts.avaPlaceholder.image
        
        switch type {
        case .image(let image):
            self.image = image ?? placeholder
        case .url(let url):
            self.setImage(url: url, placeHolder: placeholder)
        }
    }
    
}
