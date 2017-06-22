//
//  WXEmoticonPackage.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/21.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
// 表情包模型

import UIKit

class WXEmoticonPackage: NSObject {

    var id : String?
    var version : String?
    var group_name_cn: String?
    var group_name_en: String?
    var group_name_tw: String?
    var display_only: String?
    var group_type: String?
    var emoticons: Array<Any>? = []
    
    
   convenience init(withID id : String) {
        self.init()
        self.id = id
        //获取id对应的表情包的plist文件
        let plistPath = WXEmoticonDataManager.emoticonBundlePath + "/\(id)/info.plist"
    
        //获取内容
        if let emoticonsDic = NSDictionary(contentsOfFile: plistPath){
            
            self.version = emoticonsDic["version"] as? String
            self.group_name_cn = emoticonsDic["group_name_cn"] as? String
            self.group_name_en = emoticonsDic["group_name_en"] as? String
            self.group_name_tw = emoticonsDic["group_name_tw"] as? String
            self.group_type = emoticonsDic["group_type"] as? String
            
            let emoticonaArray = emoticonsDic["emoticons"] as! NSArray
            
            for emoticonDic in emoticonaArray {
                
                if emoticonDic is NSDictionary {
                    
                    let dic = emoticonDic as! [String: Any]
                    
                    if self.group_type == "2" { //默认表情
                        let emoticonModel = WXEmoticonModel()
                        emoticonModel.setValuesForKeys(dic)
                        emoticons?.append(emoticonModel)
                        
                    } else { //Emoji表情
                        let dic = emoticonDic as! NSDictionary
                        let code = dic["code"] as! String
                        // 扫描
                        let scanner = Scanner(string: code)
                        
                        var result: UInt32 = 0
                        
                        // 将结果赋值给result
                        scanner.scanHexInt32(&result)
                        
                        let char = Character(UnicodeScalar(result)!)
                        
                        let emojiModel = WXEmoticonEmojiModel()
                        emojiModel.code = code
                        emojiModel.emoji = "\(char)"
                        emoticons?.append(emojiModel)

                        
                    }
                }
                
            }
            
            
        }
    }
    
    
   private override init() {
        super.init()
       
    }
    
}
