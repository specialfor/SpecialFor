//
//  ImageAlertViewController.swift
//  Nynja
//
//  Created by Volodymyr Hryhoriev on 2/21/18.
//  Copyright © 2018 TecSynt Solutions. All rights reserved.
//

import SnapKit

private let _duration = 2.0

public final class ImageAlertViewController: UIViewController {
    
    // MARK: - Constraints
    
    private var imageViewSide: Constraint!
    
    private var messageLabelTopInset: Constraint!
    
    
    // MARK: - Properties
    
    private var image: UIImage?
    
    private var text: String?
    
    /// Default: 2.0
    public var duration: Double?
    
    public var completion: Closure?
    
    
    // MARK: - Subviews
    
    private lazy var popupView: UIView = {
        let view = UIView()
        
        view.roundCorners(radius: Constraints.popupView.cornerdRadius)
        view.backgroundColor = UIColor.clear
        
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.width.equalTo(Constraints.popupView.width)
            make.center.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        
        popupView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        let side = Constraints.imageView.width
        
        popupView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            imageViewSide = make.width.height.equalTo(side).constraint
            make.top.equalTo(Constraints.imageView.topInset)
            make.centerX.equalToSuperview()
        }
        
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        let horizontalInset = Constraints.messageLabel.horizontalInset
        
        popupView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(horizontalInset)
            make.right.equalTo(-horizontalInset)
            messageLabelTopInset = make.top.equalTo(imageView.snp.bottom).offset(Constraints.messageLabel.topInset).constraint
            make.bottom.equalTo(-Constraints.messageLabel.bottomInset)
        }
        
        return label
    }()
    
    
    // MARK: - Init
    
    public convenience init(image: UIImage?, message: String?) {
        self.init()
        
        self.image = image
        self.text = message
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
    }
    
    
    // MARK: - UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        baseSetup()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        async(after: duration ?? _duration) {
            self.presentingViewController?.dismiss(animated: true, completion: self.completion)
        }
    }
    
    
    // MARK: - Base setup
    
    public override func baseSetup() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        blurView.isHidden = false
        messageLabel.isHidden = false
        
        imageView.image = image
        if image == nil {
            imageViewSide.update(offset: 0)
        }
        
        messageLabel.text = text
        if text == nil {
            messageLabelTopInset.update(offset: 0)
        }
    }
}


extension ImageAlertViewController {
    
    enum Constraints {
        
        enum popupView {
            static let width = 270
            static let cornerdRadius: CGFloat = 12
        }
        
        enum imageView {
            static let width = 62.0
            static let topInset = 16.0
        }
        
        enum messageLabel {
            static let topInset = 16.0
            static let bottomInset = 24.0
            static let horizontalInset = 16.0
        }
        
    }
}
