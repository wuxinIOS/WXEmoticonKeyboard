//
//  WXEmoticonDataManager.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/21.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//  数据管理的单例

import UIKit

class WXEmoticonDataManager: NSObject {

    static let sharedEmoticonDataMaganer = WXEmoticonDataManager()
    
    //获取表情bundle所在的路径
   static let emoticonBundlePath = Bundle.main.path(forResource: "Emoticons", ofType: "bundle")!
   static let emoticonPlist = "emoticons.plist"
    //表情包数据
    var emoticonPackageArray = [WXEmoticonPackage]()
    
    private override init() {
        super.init()
        
        //表情包的plist文件路径
        let emoticonPlistPath = WXEmoticonDataManager.emoticonBundlePath + "/\(WXEmoticonDataManager.emoticonPlist)"
        
        //获取内容
        if let emoticonDic = NSDictionary(contentsOfFile: emoticonPlistPath),
            let emoticonPackagesArray = emoticonDic["packages"] as? NSArray{
           
            for emoticonPackageDic in emoticonPackagesArray {
                
                if emoticonPackageDic is NSDictionary {
                    let dic = emoticonPackageDic as! NSDictionary
                    let id = dic["id"] as! String
                    
                    let emoticonPackage = WXEmoticonPackage(withID: id)
                    
                    emoticonPackageArray.append(emoticonPackage)
                    
                }
            }
            
            
        }
        
    
    }
    
    
}


