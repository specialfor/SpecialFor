//
//  AlertManager.swift
//  Nynja
//
//  Created by Anton Makarov on 24.05.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit

class AlertManager {

    static let sharedInstance: AlertManager = {
        let instance = AlertManager()
        return instance
    }()
    
    private var presentingController: UIViewController? {
        return UIApplication.shared.keyWindow?.presentedViewController
    }
    
    func showAlertOk(title: String, message: String, completion: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: String.localizable.ok, style: .default) { (action) in
            completion?()
        }
        alert.addAction(defaultAction)
        present(alert, from: presentingController)
    }
    
    func showAlert(title: String, dismissInterval: TimeInterval) {
        let alert = UIAlertController(title: "\n\(title)\n ", message: "", preferredStyle: .alert)
        dispatchAsyncMainAfter(dismissInterval) {
            alert.dismiss(animated: true, completion: nil)
        }
        present(alert, from: presentingController)
    }
    
    func showAlertOk(message: String, completion:(()->Void)? = nil) {
        showAlertOk(title: "", message: message, completion: completion)
    }
    
    func showAlertOkCancel(title: String = "",
                           message: String,
                           textFieldConfig: ((UITextField) -> Void)? = nil,
                           completionOk: ((UIAlertAction) -> Void)? = nil,
                           completionCancel: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: String.localizable.ok, style: .default) { (action) in
            completionOk?(action)
        }
        let secondAction = UIAlertAction(title: String.localizable.cancel, style: .cancel) { (action) in
            completionCancel?(action)
        }
        alert.addAction(defaultAction)
        alert.addAction(secondAction)
        
        textFieldConfig.map { alert.addTextField(configurationHandler: $0) }
        
        present(alert, from: presentingController)
    }
    
    func showAlertWithTwoActions(title: String, message: String, firstActionTitle: String,
                               secondActionTitle: String, firstAction: Handler?,
                               secondAction: Handler?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: firstActionTitle, style: .default) { (action) in
            firstAction?()
        }
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
            secondAction?()
        }
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        
        present(alert, from: presentingController)
    }

    func showAlertWithThreeActions(title: String?, message: String?, firstActionTitle: String,
                                   secondActionTitle: String, thirdActionTitle: String,
                                   firstAction: Handler?, secondAction: Handler?, thirdAction: Handler?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let firstAlertAction = UIAlertAction(title: firstActionTitle, style: .default) { (action) in
            firstAction?()
        }
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
            secondAction?()
        }
        let thirdAlertAction = UIAlertAction(title: thirdActionTitle, style: .default) { (action) in
            thirdAction?()
        }
        
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        alert.addAction(thirdAlertAction)

        present(alert, from: presentingController)
    }

    func showAlertAllowPermission(title: String = "",
                                  resourceName: String,
                                  message: String? = nil,
                                  denyTitle: String? = nil,
                                  settingsTitle: String? = nil,
                                  denyCompletion:(()->Void)? = nil,
                                  settingsCompletion:(()->Void)? = nil) {

        var _message = String.localizable.pleaseAllowPermission(resourceName.localized)
        if message != nil {
            _message = message!
        }
        
        var _denyTitle = String.localizable.deny
        if denyTitle != nil {
            _denyTitle = denyTitle!
        }
        
        var _settingsTitle = String.localizable.goToSettings
        if settingsTitle != nil {
            _settingsTitle = settingsTitle!
        }
        
        AlertManager.sharedInstance.showAlertWithTwoActions(title: title, message: _message, firstActionTitle: _denyTitle, secondActionTitle: _settingsTitle, firstAction: {
            denyCompletion?()
        }, secondAction: {
            
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                settingsCompletion?()
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
            
            settingsCompletion?()
        })
    }

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { alert.addAction($0) }
        present(alert, from: presentingController)
    }
    
    func linkMenu(open:(()->Void)? = nil, showInChat:(()->Void)? = nil, share:(()->Void)? = nil, cancel: (()->Void)? = nil) {
        var actions = [UIAlertAction]()
        
        let openAction = UIAlertAction(title: String.localizable.open, style: .default) { (action) in
            open?()
        }
        
        let showInChatAction = UIAlertAction(title: String.localizable.showInChat, style: .default) { (action) in
            showInChat?()
        }
        let showShare = UIAlertAction(title: String.localizable.share, style: .default) { (action) in
            share?()
        }
        let cancel = UIAlertAction(title: String.localizable.cancel, style: .cancel) { (action) in
            cancel?()
        }
        
        actions.append(openAction)
        actions.append(showInChatAction)
        actions.append(showShare)
        actions.append(cancel)
        self.showActionSheet(title: nil, message: nil, actions: actions)
    }
    
    func linkMenu(firstActionTitle: String, open:(()->Void)? = nil, share:(()->Void)? = nil, copy:(()->Void)? = nil, cancel: (()->Void)? = nil) {
        var actions = [UIAlertAction]()
        
        let openAction = UIAlertAction(title: firstActionTitle, style: .default) { (action) in
            open?()
        }
        
        let showShare = UIAlertAction(title: String.localizable.share, style: .default) { (action) in
            share?()
        }
        
        let copyAction = UIAlertAction(title: String.localizable.copyLink, style: .default) { (action) in
            copy?()
        }
        let cancel = UIAlertAction(title: String.localizable.cancel, style: .cancel) { (action) in
            cancel?()
        }
        actions.append(openAction)
        actions.append(copyAction)
        actions.append(showShare)
        actions.append(cancel)
        self.showActionSheet(title: nil, message: nil, actions: actions)
    }
    
    func linkMenu(url: URL, open:((URL) ->Void)? = nil, share:((URL)->Void)? = nil, copy:((URL)->Void)? = nil, cancel: (()->Void)? = nil) {
        let schemedUrl = url.getUrlWithScheme()
        let actionTitle: String
        switch schemedUrl.scheme {
        case "tel":
            actionTitle = String.localizable.call
        case "mailto":
            actionTitle = String.localizable.sendEmail
        default:
            actionTitle = String.localizable.open
        }
        linkMenu(firstActionTitle:actionTitle, open: {
            open?(schemedUrl)
        }, share: {
            share?(schemedUrl)
        }, copy: {
            copy?(schemedUrl)
        }, cancel: cancel)
    }
    
    func showNativeShare(with activityItems: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, from: presentingController)
    }
}


// MARK: - No Internet connection

extension AlertManager {
    
    func showNoInternetConnection() {
        showAlertOk(message: String.localizable.noInternetConnection)
    }
}


// MARK: - AlertImageViewController

extension AlertManager {
    
    func showImageAlert(with image: UIImage?, message: String?, on viewController: UIViewController? = nil, duration: Double? = nil, completion: AlertImageViewController.DismissCompletion? = nil) {
        let alertController = AlertImageViewController(image: image, message: message)
        
        alertController.duration = duration
        alertController.completion = completion

        let presentingVC = viewController ?? presentingController
        present(alertController, from: presentingVC)
    }
}

 
//MARK: - TimeFieldViewController

extension AlertManager {
    
    func showTimeFieldAlert(with initialValue: Int, completion: TimeCallback?) {
        let alertControler = AlertTextFieldViewController(initialValue: initialValue)
        alertControler.completion = completion
        present(alertControler, from: presentingController)
    }
}


// MARK: - Private

private extension AlertManager {
    
    func present(_ vc: UIViewController, from presentingVC: UIViewController?, animated: Bool = true) {
        guard let presentingVC = presentingVC else {
            return
        }
        
        dispatchAsyncMain {
            presentingVC.present(vc, animated: animated, completion: nil)
        }
    }
}
