//
//  ScheduleButton.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 2/14/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

final class ScheduleButton: UIButton, TopSwipable {
    
    private let bottomInset: CGFloat = CGFloat(12.0).adjustedByWidth
    
    var rightInset = ScheduleView.Constraints.upArrowScheduleView.right {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var recognizer: GestureRecognizerClosure<LongPressWithUpSwipeGestureRecognizer>!
    
    
    // MARK: - Actions
    
    var scheduleAction: (() -> Void)?
    
    var shouldBeginAction: (() -> Bool)?
    
    var beginAction: TopSwipeAction?

    var swipeAction: TopSwipeAction?
    
    var cancelAction: TopSwipeAction?
    
    
    // MARK: - Views
    
    private var scheduleView: ScheduleView?
    
    private func makeScheduleView(in window: UIWindow?) -> ScheduleView {
        self.scheduleView?.removeFromSuperview()
        
        let scheduleView = ScheduleView()
        
        window?.addSubview(scheduleView)
        scheduleView.snp.makeConstraints { maker in
            maker.left.right.top.equalToSuperview()
            maker.bottom.equalTo(self.snp.top).offset(-bottomInset)
        }
        
        return scheduleView
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetup()
    }
    
    
    // MARK: - Life Cycle
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window == nil {
            hideScheduleView()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scheduleView?.rightInset = rightInset
    }
    
    
    // MARK: - Setup
    
    private func baseSetup() {
        setup()
        
        beginAction = { [weak self] in
            self?.showScheduleView()
        }
    
        swipeAction = { [weak self] in
            guard let self = self else { return }
            self.scheduleAction?()
            self.hideScheduleView()
        }
        
        cancelAction = { [weak self] in
            self?.hideScheduleView()
        }
    }

    
    // MARK: - Show / Hide
    
    private func showScheduleView() {
        scheduleView = makeScheduleView(in: window)
        scheduleView?.rightInset = rightInset
        scheduleView?.isHidden = false
        scheduleView?.isUserInteractionEnabled = true
        scheduleView?.layer.zPosition = 1
        scheduleView?.baseSetup()
    }
    
    private func hideScheduleView() {
        scheduleView?.removeFromSuperview()
        scheduleView = nil
    }
}
