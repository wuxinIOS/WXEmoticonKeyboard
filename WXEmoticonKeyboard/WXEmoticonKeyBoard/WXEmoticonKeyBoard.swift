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

    var emoticonKeyBoardTool : WXEmoticonKeyBoardBottomTool!
    
    
    
    private override init(frame: CGRect) {
        super.init(frame:frame)
        setupBottomTool()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:--初始化UI
extension WXEmoticonKeyBoard {
    
    
    //MARK:--底部工具条
    fileprivate func setupBottomTool() {
        
        emoticonKeyBoardTool = WXEmoticonKeyBoardBottomTool(frame: CGRect(x: 0, y: self.frame.height - 40, width: UIScreen.main.bounds.width, height: 40))
        emoticonKeyBoardTool.dataSource = ["最近使用","默认","Emoji","收藏","自定义","下载"]
        addSubview(emoticonKeyBoardTool)
        
        
        
    }
    
    
}
