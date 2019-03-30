//
//  ScrollBar.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 11/9/17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import SnapKit

private let _scrollBarWidth: CGFloat = CGFloat(22.0)
private let _sliderSize = CGSize(width: _scrollBarWidth, height: CGFloat(54.0))
private let _handleWidth = CGFloat(6.0)

public final class ScrollBar: View {
    public typealias ShouldShowAction = ClosureProducer<Bool>
    
    private var sliderSize: CGSize = _sliderSize
    
    //Set true if you want to keep scroll bar position on reloadData
    public var isOnUpdate: Bool = false
    
    /// Default: main theme red color
    public var handleColor: UIColor = .red {
        didSet {
            handleView.backgroundColor = handleColor
        }
    }
    
    public var shouldShowAction: ShouldShowAction?
    
    // Default: .zero
    public var verticalInset: VerticalInset = .zero {
        didSet {
            didInsetsChanged()
        }
    }
    
    private let handleRightInset = CGFloat(4.0)
    private let pinTopInset = CGFloat(16.0)
    
    
    // MARK: - Constraints
    
    private var topInsetConstraint: Constraint!
    private var bottomInsetContraint: Constraint!
    
    
    // MARK: - Subviews
    
    @objc public var scrollView: UIScrollView? {
        willSet {
            unscribeKVO()
        }
        didSet {
            adjustScrollBar()
        }
    }
    
    private lazy var sliderView: UIView = {
        let origin = CGPoint(x: _scrollBarWidth - sliderSize.width, y: 0)
        let frame = CGRect(origin: origin, size: sliderSize)
        
        let view = UIView(frame: frame)
        view.backgroundColor = .clear
        
        self.addSubview(view)
        return view
    }()
    
    private lazy var handleView: UIView = {
        let frame = CGRect(x: _sliderSize.width - _handleWidth - handleRightInset, y: 0, width: _handleWidth, height: sliderSize.height)
        
        let view = UIView(frame: frame)
        
        view.layer.cornerRadius = _handleWidth / 2
        view.backgroundColor = handleColor
        
        sliderView.addSubview(view)
        
        return view
    }()
    
    private(set) lazy var infoView: PinView = {
        let pin = PinView()
        
        pin.titleLabel.text = "A"
        
        let rightInset = 2 * handleRightInset + _handleWidth
        let width = 64.0
        
        self.addSubview(pin)
        pin.snp.makeConstraints { (make) in
            make.width.height.equalTo(width)
            
            make.top.greaterThanOrEqualToSuperview()
            make.right.equalTo(-rightInset)
            make.bottom.equalTo(sliderView.snp.top).offset(pinTopInset).priority(750)
        }
        
        return pin
    }()
    
    
    // MARK: - Init
    
    public convenience init(scrollView: UIScrollView) {
        self.init(frame: CGRect.zero)
        self.scrollView = scrollView
        adjustScrollBar()
    }
    
    
    // MARK: - Setup
    
    public override func baseSetup() {
        super.baseSetup()
        
        self.clipsToBounds = false
        self.backgroundColor = .clear
        
        infoView.alpha = 0.0
        
        sliderView.isUserInteractionEnabled = true
        handleView.isUserInteractionEnabled = false
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(sliderPanned(_:)))
        sliderView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecofnizer = UITapGestureRecognizer(target: self, action: #selector(barTapped(_:)))
        self.addGestureRecognizer(tapGestureRecofnizer)
        
        setupTestingKeys()
    }
    
    private func adjustScrollBar() {
        self.removeFromSuperview()
        if let scrollView = self.scrollView {
            scrollView.showsVerticalScrollIndicator = false
            
            let superview = scrollView.superview
            superview?.addSubview(self)
            superview?.bringSubviewToFront(self)
            
            let topInset = scrollView.contentInset.top + verticalInset.top
            let bottomInset = scrollView.contentInset.bottom + verticalInset.bottom
            
            self.snp.remakeConstraints({ (make) in
                make.width.equalTo(_scrollBarWidth)
                make.right.equalTo(scrollView)
                topInsetConstraint = make.top.equalTo(scrollView).offset(topInset).constraint
                bottomInsetContraint = make.bottom.equalTo(scrollView).offset(-bottomInset).constraint
            })
            
            toggleScrollBar()
        }
        
        subscribeKVO()
    }
    
    
    // MARK: - KVO
    
    private var offsetObservation: NSKeyValueObservation?
    private var sizeObservation: NSKeyValueObservation?
    private var insetsObservation: NSKeyValueObservation?
    
    private func subscribeKVO() {
        offsetObservation = observe(\.scrollView?.contentOffset, changeHandler: { (object, change) in
            self.didOffsetChanged()
        })
        
        sizeObservation = observe(\.scrollView?.contentSize, changeHandler: { (object, change) in
            self.didSizeChanged()
        })
        
        insetsObservation = observe(\.scrollView?.contentInset, changeHandler: { (object, change) in
            self.didInsetsChanged()
        })
    }
    
    private func unscribeKVO() {
        offsetObservation = nil
        sizeObservation = nil
        insetsObservation = nil
    }
    
    private func didOffsetChanged() {
        if isDragging || isOnUpdate {
            return
        }
        guard let scrollView = self.scrollView else {
            return
        }
            
        let centerY = calculateCenterY(from: scrollView)
        sliderView.center.y = centerY
    }
    
    private func didSizeChanged() {
        toggleScrollBar()
    }
    
    private func didInsetsChanged() {
        guard let scrollView = self.scrollView else { return }
        
        let topInset = scrollView.contentInset.top + verticalInset.top
        let bottomInset = scrollView.contentInset.bottom + verticalInset.bottom
        
        self.snp.updateConstraints { make in
            topInsetConstraint.update(offset: topInset)
            bottomInsetContraint.update(offset: -bottomInset)
        }
    }
    
    
    // MARK: - UIPanGestureRecognizer
    
    private var deltaY: CGFloat = 0
    private var isDragging: Bool = false
    
    
    @objc private func sliderPanned(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        switch recognizer.state {
        case .began:
            deltaY = sliderView.center.y - location.y
            isDragging = true
            
            toggleInfoView(shouldHide: false)
            break
        case .changed:
            updateLocation(location)
            break
        case .ended, .cancelled:
            deltaY = 0
            isDragging = false
            
            toggleInfoView(shouldHide: true)
            break
        default:
            break
        }
    }

    
    // MARK: - TapGestureRecognizer
    
    @objc private func barTapped(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        updateLocation(location)
    }
    
    
    // MARK: - Utils
    
    private func updateLocation(_ location: CGPoint) {
        guard let scrollView = self.scrollView else { return }
        
        let centerY = calculateCenterY(location)
        sliderView.center.y = centerY
        
        let offsetY = calculateOffsetY(scrollView, centerY: centerY)
        scrollView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
    }
    
    private func toggleInfoView(shouldHide: Bool) {
        let alpha: CGFloat = shouldHide ? 0.0 : 1.0
        UIView.animate(withDuration: 0.3) {
            self.infoView.alpha = alpha
        }
    }
    
    private func toggleScrollBar() {
        guard let scrollView = self.scrollView else { return }
        
        let shouldHide = !(shouldShowAction?() ?? true)
        self.isHidden = shouldHide || scrollView.bounds.height >= scrollView.contentSize.height
    }
}


// MARK: - Calculation

fileprivate extension ScrollBar {
    
    private var halfSliderHeight: CGFloat {
        return sliderView.bounds.height / 2
    }
    
    private var sliderDistance: CGFloat {
        return self.bounds.height - 2 * halfSliderHeight
    }
    
    private func calculateCenterY(_ location: CGPoint) -> CGFloat {
        return normalize(location.y - deltaY)
    }
    
    private func calculateOffsetY(_ scrollView: UIScrollView, centerY: CGFloat) -> CGFloat {
        let proportion = (centerY - halfSliderHeight) / (sliderDistance)
        return scrollableHeight(scrollView) * proportion
    }
    
    private func calculateCenterY(from scrollView: UIScrollView) -> CGFloat {
        let offsetY = scrollView.contentOffset.y
        let proportion = offsetY / scrollableHeight(scrollView)
        
        let centerY = halfSliderHeight + sliderDistance * proportion
        
        return normalize(centerY)
    }
    
    private func scrollableHeight(_ scrollView: UIScrollView) -> CGFloat {
        let lower: CGFloat = 0
        
        let verticalInsets = scrollView.contentInset.top + scrollView.contentInset.bottom
        
        let upper = scrollView.contentSize.height - scrollView.bounds.height + verticalInsets
        
        return upper - lower
    }
    
    private func normalize(_ centerY: CGFloat) -> CGFloat {
        return min(max(halfSliderHeight, centerY), self.bounds.height - halfSliderHeight)
    }
}


// MARK: - Constraints

extension ScrollBar {
    
    public struct VerticalInset {
        public let top: CGFloat
        public let bottom: CGFloat
        
        public static let zero = VerticalInset(top: 0, bottom: 0)
    }
}


// MARK: - Testable

extension ScrollBar {
    
    private enum Keys: String {
        case sliderView         = "slider_view"
        case handleView         = "handle_view"
        case infoView           = "info_view"
    }
    
    func setupTestingKeys() {
        sliderView.accessibilityIdentifier          = Keys.sliderView.rawValue
        handleView.accessibilityIdentifier          = Keys.handleView.rawValue
        infoView.accessibilityIdentifier            = Keys.infoView.rawValue
    }
}
