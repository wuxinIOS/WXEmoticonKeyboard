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
    
    //表情包分组
    var emoticonPackageGroupArray = [Int]()
    
    
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
            
            //默认3行7列
            _ = numberOfItem(3, 7)
            
        }
    }
    
    
    //根据行和列的数量来计算每组表情的个数
    func numberOfItem(_ row:Int,_ col:Int) -> [Int] {
        //3行7列 totalCount =  3 * 7 -1 = 20
        let groupCount = row * col - 1
        var packageOfGroupArray = [Int]()
        for i in 0..<emoticonPackageArray.count {
            let package = emoticonPackageArray[i]
            let count = package.emoticons!.count % groupCount == 0 ? (package.emoticons!.count / groupCount) : (package.emoticons!.count / groupCount + 1)
            packageOfGroupArray.append(count)
            
        }
        
        emoticonPackageGroupArray = packageOfGroupArray
        
        return packageOfGroupArray
    }
    
}



