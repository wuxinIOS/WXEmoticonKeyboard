//
//  WXEmoticonTextView.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/22.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

class WXEmoticonTextView: UITextView {
    
    //重写copy方法（对复制表情进行处理）
    override func copy(_ sender: Any?) {
        var copyString = ""
        
        attributedText.enumerateAttributes(in: selectedRange, options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (result, range, _) -> Void in
            if let attachment = result["NSAttachment"] as? NSTextAttachment
            {
                copyString += "hahhah"
            }
            else
            {
                let str = (self.attributedText.string as NSString).substring(with: range)
                copyString += str
                
            }
        }
        let pasteboard = UIPasteboard.general
        pasteboard.string = copyString

    }
    
    
    //重写cut方法（对剪切表情进行处理）
    
    
    
    override func cut(_ sender: Any?) {
        var copyString = ""
        attributedText.enumerateAttributes(in: selectedRange, options: NSAttributedString.EnumerationOptions(rawValue: 0)) { (result, range, _) -> Void in
            if let attachment = result["NSAttachment"] as? NSTextAttachment
            {
                copyString += ""
            }
            else
            {
                let str = (self.attributedText.string as NSString).substring(with: range)
                copyString += str
                
            }
        }
        super.cut(sender)
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = copyString
    }

    
    
    /*
     * 添加一个表情到textView
     * emoticon: 要添加的表情模型
     */
    func insertEmoticon(emoticonPath: String) {
        
            if emoticonPath.characters.count < 10 {
                insertText(emoticonPath)
                return
            }
        
            //图片表情
        
            // 创建附件
            let attachment = NSTextAttachment()
            
            // 设置附件的大小
            attachment.bounds = CGRect(x: 0, y: -4, width: (font?.lineHeight)!, height: (font?.lineHeight)!)
            // 给附件添加图片
            attachment.image = UIImage(contentsOfFile: emoticonPath)
            
            
            // 创建一个属性文本,属性文本有一个附件,附件里面有一张图片
            let attrString = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        
        
            // 给附件添加Font属性
            attrString.addAttribute(NSFontAttributeName, value: font!, range: NSRange(location: 0, length: 1))
            
            // 拿出textView内容
            let temp = NSMutableAttributedString(attributedString: attributedText)
            
            // 获取textView选中的范围，把图片添加到已有内容里面
            let sRange = self.selectedRange
            temp.replaceCharacters(in: sRange, with: attrString)
            
            // 在重新赋值回去
            attributedText = temp
            
            // 重新设置选中范围,让光标在插入表情后面
            self.selectedRange = NSRange(location: sRange.location + 1, length: 0)
            
            //让光标位置可见
            self.scrollRangeToVisible(self.selectedRange)
            
            // 手动触发textView文本改变
            // 发送通知,文字改变
          //  NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: self)
            
            // 调用代理,文字改变
            //delegate?.textViewDidChange?(self)
        
    }
    


}
