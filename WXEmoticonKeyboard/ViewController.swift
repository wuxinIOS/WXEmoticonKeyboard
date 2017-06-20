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
    
    
    lazy var emoticonKeyBoard : UIView! = {
        
        let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 255, width: UIScreen.main.bounds.width, height: 255))
        view.backgroundColor = UIColor.orange
        return view
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(textFileChanged), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    @objc fileprivate func textFileChanged(notifiction:Notification) {
        
        /**NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        
        NSLog(@"keyBoard:%f", keyboardSize.height);  //216
        */
        
        let info = notifiction.userInfo
        let frame = info?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        
        
        UIView.animate(withDuration: 0.25) { 
            
            self.toolBottomContraint.constant = UIScreen.main.bounds.height - frame.origin.y
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

