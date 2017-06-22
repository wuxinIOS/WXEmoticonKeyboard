//
//  WXEmoticonCollectionView.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/21.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

@objc protocol WXEmoticonCollectionViewDelegate:NSObjectProtocol {
    
    func emoticonCollectionView(_ collectionView:WXEmoticonCollectionView,scrollToIndexPaht indexPath:IndexPath)
    //删除
    @objc optional func emoticonCollectionView(_ collectionView:WXEmoticonCollectionView,deleteDefaultEmoticon: WXEmoticonModel?, deleteEmojiEmoticon: WXEmoticonEmojiModel?)
    
    //选择
    @objc optional func emoticonCollectionView(_ collectionView:WXEmoticonCollectionView,selectDefaultEmoticon: WXEmoticonModel?, selectEmojiEmoticon: WXEmoticonEmojiModel?)
}



class WXEmoticonCollectionView: UICollectionView {

    
    weak var emoticonCollectionViewDelegate: WXEmoticonCollectionViewDelegate?
    
    let reuseIdentifier = "WXEmoticonCollectionViewCell"
    
    var lastIndexPath:IndexPath! = IndexPath(item: 0, section: 0)
    
    var sectionAndItem = [(Int,Int)]()
    
    var numberSection : [Int]! {
        
        didSet{
            self.reloadData()
        }
    }

    
    convenience init(frame:CGRect,section:[Int]){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.init(frame: frame, collectionViewLayout: layout)
        numberSection = section
        backgroundColor = UIColor.white
        register(WXEmoticonCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.delegate = self
        self.dataSource = self
        isPagingEnabled = true
        
    }
    
   private override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension WXEmoticonCollectionView:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,WXEmoticonCollectionViewCellDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberSection[section]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WXEmoticonCollectionViewCell
        
        //获取对应的表情包
        let emoticonPackage = WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageArray[indexPath.section]
        
        //获取对应cell的所有表情
        var emoticons = [Any]()
        if indexPath.item == numberSection[indexPath.section] - 1 {
            //获取对应所有表情
            let length = emoticonPackage.emoticons.count - (indexPath.item) * 20
            let location = indexPath.item  * length
            let range = NSRange(location: location, length: length)
            emoticons = emoticonPackage.emoticons.subarray(with: range)

        } else {
            //获取对应所有表情
            let length = 20
            let location = indexPath.item * length
            let range = NSRange(location: location, length: length)
            emoticons = emoticonPackage.emoticons.subarray(with: range)
            
        }
        
        cell.emotionArray = emoticons
        cell.emoticonCollectionViewCellDelegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.frame.width
        let height = self.frame.height
        let size = CGSize(width: width, height: height)
        return size
        
    }
    
    //滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let indexPath = self.indexPathForItem(at: scrollView.contentOffset)
        
        if let delegate =  emoticonCollectionViewDelegate,
            let indexPath = indexPath {
            
            if delegate.responds(to: #selector(WXEmoticonCollectionViewDelegate.emoticonCollectionView(_:scrollToIndexPaht:))) {
                
                delegate.emoticonCollectionView(self, scrollToIndexPaht: indexPath)
            }
        }
    }
    
    
    //滚动停止
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
        
        let indexPath = self.indexPathForItem(at: scrollView.contentOffset)
        
        if let delegate =  emoticonCollectionViewDelegate,
            let indexPath = indexPath {
            
            if delegate.responds(to: #selector(WXEmoticonCollectionViewDelegate.emoticonCollectionView(_:scrollToIndexPaht:))) {
                
                delegate.emoticonCollectionView(self, scrollToIndexPaht: indexPath)
            }
            
        }
        
    }
    
    
    func emoticonCollectionViewCell(_ cell: WXEmoticonCollectionViewCell, deleteDefaultEmoticon: WXEmoticonModel?, deleteEmojiEmoticon: WXEmoticonEmojiModel?) {
        
        if let delegate =  emoticonCollectionViewDelegate{
            
            if delegate.responds(to: #selector(WXEmoticonCollectionViewDelegate.emoticonCollectionView(_:deleteDefaultEmoticon:deleteEmojiEmoticon:))) {
                
                delegate.emoticonCollectionView!(self, deleteDefaultEmoticon: deleteDefaultEmoticon, deleteEmojiEmoticon: deleteEmojiEmoticon)
            }
            
        }
    }
    
    func emoticonCollectionViewCell(_ cell: WXEmoticonCollectionViewCell, selectDefaultEmoticon: WXEmoticonModel?, selectEmojiEmoticon: WXEmoticonEmojiModel?) {
        
        if let delegate =  emoticonCollectionViewDelegate{
            
            if delegate.responds(to: #selector(WXEmoticonCollectionViewDelegate.emoticonCollectionView(_:selectDefaultEmoticon:selectEmojiEmoticon:))) {
                
                delegate.emoticonCollectionView!(self, selectDefaultEmoticon: selectDefaultEmoticon, selectEmojiEmoticon: selectEmojiEmoticon)
            }
            
        }
        
        
    }
    
}



