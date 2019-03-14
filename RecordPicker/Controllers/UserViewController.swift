//
//  UserViewController.swift
//  RecordPicker
//
//  Created by Tiago Valente on 05/11/2018.
//  Copyright © 2018 Tiago Valente. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {

    @IBOutlet var viewFloating: UIView!
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    
    @IBOutlet var textFieldUsername: UITextField!
    
    @IBOutlet var confirmButton: UIButton!
    
    @IBOutlet var popupViewYConstraint: NSLayoutConstraint!
    var tapGesture = UITapGestureRecognizer()
    
    func setupView() {
        
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 22.0)
        labelTitle.text = "Welcome"
        
        labelDescription.textAlignment = .center
        labelDescription.font = UIFont.systemFont(ofSize: 17.0)
        labelDescription.text = "Before we begin please provide your Discogs username so that we can access your personal collection."
        
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitle( "Confirm", for: .selected)
        confirmButton.tintColor = UIColor.black
        
        textFieldUsername.placeholder = "Enter username"
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        viewFloating.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .setupViewResizerOnKeyboardShown()
        viewFloating.layer.cornerRadius = 8
        self.setupView()
    }

    func dismissComponent() {
        viewFloating.alpha = 1.0;
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.viewFloating.alpha = 0;
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    @IBAction func confirmButtonAction(_ sender: UIButton) {
        if let username = textFieldUsername.text, !username.isEmpty {
            Helper.saveUsername(username)
            dismissComponent()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.dismissKeyboard()
    }
    
    func animateView() {
        self.viewFloating.alpha = 0;
        self.viewFloating.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        UIView.animate(withDuration: 0.7, animations: { () -> Void in
            self.viewFloating.alpha = 1.0;
            self.viewFloating.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    override func keyboardWillHideForResizing(notification: Notification) {
        popupViewYConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    override func keyboardWillShowForResizing(notification: Notification) {
        popupViewYConstraint.constant = -90
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
