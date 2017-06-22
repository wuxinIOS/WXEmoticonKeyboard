//
//  WXEmoticonCollectionViewCell.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/22.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

@objc protocol WXEmoticonCollectionViewCellDelegate:NSObjectProtocol {
    
    @objc optional func emoticonCollectionViewCell(_ cell:WXEmoticonCollectionViewCell,selectDefaultEmoticon:WXEmoticonModel?, selectEmojiEmoticon:WXEmoticonEmojiModel? )
    
    @objc optional func emoticonCollectionViewCell(_ cell:WXEmoticonCollectionViewCell,deleteDefaultEmoticon:WXEmoticonModel?, deleteEmojiEmoticon:WXEmoticonEmojiModel?)
    
}

class WXEmoticonCollectionViewCell: UICollectionViewCell {
    
    let row = 3
    let col = 7
    
    var isFirst = true
    
    private let margin: UIEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10) //边缘
    private let emoticonWidth: CGFloat = 32 //emoji表情显示的宽
   
    weak var emoticonCollectionViewCellDelegate:WXEmoticonCollectionViewCellDelegate?
    
    
    //表情点击范围的宽
    private var itemWidth: CGFloat {
        return (self.bounds.width - margin.left - margin.right) / CGFloat(col)
    }
    
    //表情点击范围的高
    private var itemHeight: CGFloat {
        return (self.bounds.height - margin.top - margin.bottom) / CGFloat(row)
    }
    
    var emotionArray : [Any]? {
        didSet{
            
            self.setNeedsDisplay()
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectEmoticon))
        addGestureRecognizer(tap)
        
        
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let emotionArray = emotionArray else{
            return
        }
        
        var index = 0

        for emotion in emotionArray {
            
            if let emotion = emotion as? WXEmoticonModel {//默认表情
                let image = UIImage(contentsOfFile: emotion.pngPath!)
                drawImage(image!, index: index)
                
            } else { //emoji表情
                
                let emoticonEmoji = emotion as! WXEmoticonEmojiModel
                drawEmoji(emoticonEmoji.emoji!, index: index)
            }
            
            index += 1
            
            if index == emotionArray.count - 1 {
                //如果有删除按钮，在最后一个位置画删除按钮
                let deletePath = WXEmoticonDataManager.emoticonBundlePath + "/compose_emotion_delete.imageset/compose_emotion_delete.png"
                if let image = UIImage(contentsOfFile: deletePath) {
                    drawImage(image, index: 20)
                }

            }
            
            
        }
        
        
        
    }
    
    
    private func drawImage(_ image:UIImage,index:Int) {
        
        let width:CGFloat = 30
        let height:CGFloat = 30
        
        
        let leftMargin = (itemWidth - width) / 2.0   //计算出居中所需的边缘
        let topMargin = (itemHeight - height) / 2.0

        let x = margin.left + itemWidth * CGFloat(index % col)  + leftMargin   //x坐标
        let y = margin.top + itemHeight * CGFloat(index / col) + topMargin   //y坐标
        image.draw(in: CGRect(x: x, y: y, width: width, height: height))
        
        
    }
    
    private func drawEmoji(_ emoji:String,index:Int) {
       
        let font = UIFont.systemFont(ofSize: 32)
        let emojiWidth = font.lineHeight
        let leftMargin = (itemWidth - emojiWidth) / 2.0   //计算出居中所需的边缘
        let topMargin = (itemHeight - emojiWidth) / 2.0
        
        let x = margin.left + itemWidth * CGFloat(index % col) + leftMargin + 2   //x坐标
        let y = margin.top + itemHeight * CGFloat(index / col) + topMargin + 1   //y坐标
       
        let emo = emoji as NSString
        
        emo.draw(in: CGRect(x: x, y: y, width: emojiWidth, height: emojiWidth), withAttributes: [NSFontAttributeName: font])
    }
    
    @objc private func selectEmoticon(tap:UITapGestureRecognizer) {
        
        guard let emoticons = self.emotionArray else {
            return
        }
        
        if let index = indexWithLocation(location: tap.location(in: self)) {
            if index == 20 {
                //删除
                if let delegate = emoticonCollectionViewCellDelegate {
                    if delegate.responds(to: #selector(WXEmoticonCollectionViewCellDelegate.emoticonCollectionViewCell(_:deleteDefaultEmoticon:deleteEmojiEmoticon:))) {
                        
                            
                            delegate.emoticonCollectionViewCell!(self, deleteDefaultEmoticon: nil, deleteEmojiEmoticon: nil)
                      
                    }
                }
                
            } else if (index < 20) && index < emoticons.count {
               // let emoticon = emoticons[index]
                if let delegate = emoticonCollectionViewCellDelegate {
                    if delegate.responds(to: #selector(WXEmoticonCollectionViewCellDelegate.emoticonCollectionViewCell(_:deleteDefaultEmoticon:deleteEmojiEmoticon:))) {
                        if let emoticon = emotionArray![index] as? WXEmoticonModel {
                            
                            delegate.emoticonCollectionViewCell!(self, selectDefaultEmoticon: emoticon, selectEmojiEmoticon: nil)
                        } else {
                            let emoticon = emotionArray![index] as! WXEmoticonEmojiModel
                           
                            delegate.emoticonCollectionViewCell!(self, selectDefaultEmoticon: nil, selectEmojiEmoticon: emoticon)
                        }
                    }
                }
            }
        }

    }
    
    //触摸的是哪个表情
    private func indexWithLocation(location: CGPoint) -> Int? {
        //触摸不在范围内，返回nil
        if location.x < margin.left || location.x > (self.bounds.width - margin.right) || location.y < margin.top || location.y > (self.bounds.height - margin.bottom) {
            return nil
        } else {
            //触摸的行、列
            let column = Int((location.x - margin.left) / itemWidth)
            let row = Int((location.y - margin.top) / itemHeight)
            return row * col + column
        }
    }
    
}
