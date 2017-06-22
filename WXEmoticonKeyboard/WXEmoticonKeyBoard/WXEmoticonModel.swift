//
//  WXEmoticonModel.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/21.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//  具体表情模型

import UIKit

class WXEmoticonModel: NSObject {

    var chs: String?
    var cht: String?
    var gif: String?
    var png: String?
    var type: String?
    var pngPath: String?
    
    override func value(forUndefinedKey key: String) -> Any? {
        if key == "pngPath" {
            return nil
        }
        
        return key
    }
    
    
}


class WXEmoticonEmojiModel: NSObject {
    
    var code: String?
    var type: String?
    var emoji: String?//表情图字符串
}
