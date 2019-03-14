//
//  BaseViewController.swift
//  RecordPicker
//
//  Created by Tiago Valente on 31/12/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var viewTap: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        
        hideKeyboardWhenTappedAround()
        resignFirstResponder()
    }
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShowForResizing),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHideForResizing),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

extension BaseViewController : UIGestureRecognizerDelegate {
    
    func hideKeyboardWhenTappedAround() {
        if viewTap == nil {
            viewTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            viewTap?.cancelsTouchesInView = false
            viewTap?.delegate = self
            view.addGestureRecognizer(viewTap!)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShowForResizing(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = self.view.window?.frame {
            // We're not just minusing the kb height from the view height because
            // the view could already have been resized for the keyboard before
            UIView.animate(withDuration: 0.3, animations: {
                self.view.frame = CGRect(x: self.view.frame.origin.x,
                                         y: self.view.frame.origin.y,
                                         width: self.view.frame.width,
                                         height: window.origin.y + window.height - keyboardSize.height)
            })
            
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }
    
    @objc func keyboardWillHideForResizing(notification: Notification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: UIScreen.main.bounds.size.height)
        })
    }
    
}
