//
//  EntryPointViewController.swift
//  HistoricalEvents2
//
//  Created by Andros Slowley on 12/10/16.
//  Copyright © 2016 Andros Slowley. All rights reserved.
//

import UIKit

class EntryPointViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var backView: UIImageView!
    
    @IBOutlet weak var viewFromTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        password.delegate = self
        startGame.isEnabled = false
        backView.image = UIImage.init(named: "splash_screen")
        password.isSecureTextEntry = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.moveKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.textFieldShouldReturn(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: UITextField())
    }


func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard userName.text == "aslowle1" && password.text == "password" else {
            return false
        }
        
        password.resignFirstResponder()
        userName.resignFirstResponder()
        startGame.isEnabled = true
        return true
    }
    
    func moveKeyboard(_ notification: Notification) {
        if let notify = notification.userInfo, let size = notify[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            print("moving")
            let valueToMove = size.cgRectValue
            
             self.viewFromTop.constant += (valueToMove.size.height + 100.0)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
        }
        
    }
    
    
}
