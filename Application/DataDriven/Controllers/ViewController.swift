//
//  ViewController.swift
//  Nennos Pizza
//
//  Created by Volodymyr Hryhoriev on 3/28/19.
//  Copyright © 2019 Specialfor. All rights reserved.
//

import SnapKit

public class ViewController: UIViewController {
    public var presenter: Presenter?
    
    private var notificationCenter: NotificationCenter {
        return .default
    }
    
    public var bottomSafeAreaColor: UIColor? {
        didSet { bottomView.backgroundColor = bottomSafeAreaColor }
    }
    
    // MARK: - Subviews
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        self.view.addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(UIWindow.bottomInset)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        baseSetup()
        presenter?.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppear()
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Keyboard
    
    @objc private func keyboardWillShow() {
        presenter?.keyboardWillShow()
    }
}
