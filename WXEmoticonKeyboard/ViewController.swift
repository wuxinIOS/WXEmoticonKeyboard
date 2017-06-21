//
//  ViewController.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/20.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changedKeyboardButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var toolBottomContraint: NSLayoutConstraint!
    
    
    lazy var emoticonKeyBoard : WXEmoticonKeyBoard! = WXEmoticonKeyBoard.sharedEmoticonKeyBoard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(textFileChanged), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    @objc fileprivate func textFileChanged(notifiction:Notification) {
        
        let info = notifiction.userInfo
        let frame = info?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        
        
        self.toolBottomContraint.constant = UIScreen.main.bounds.height - frame.origin.y
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
    @IBAction func changedKeyboardBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            textField.inputView = emoticonKeyBoard
        } else {
            textField.inputView = nil
        }
        textField.becomeFirstResponder()
        textField.reloadInputViews()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

