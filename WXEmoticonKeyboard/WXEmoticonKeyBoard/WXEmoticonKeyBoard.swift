//
//  WXEmoticonKeyBoard.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/20.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//   表情键盘视图(单例)

import UIKit

class WXEmoticonKeyBoard: UIView {

    static let sharedEmoticonKeyBoard =  WXEmoticonKeyBoard(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))

    private override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//
