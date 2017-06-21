//
//  WXEmoticonKeyBoardBottomTool.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/20.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//  表情键盘底部分类的工具条
/**
    由collectionView 作为主要展示界面
 
 */

import UIKit

@objc protocol WXEmoticonBoardBottomToolBarDelegate {
    func emoticonKeyBoardBottomTool(emoticonToolbar: WXEmoticonKeyBoardBottomTool, didSelectItemAtIndex index: Int)
}

class WXEmoticonKeyBoardBottomTool: UIToolbar, UICollectionViewDelegateFlowLayout {

    fileprivate var collectionView : UICollectionView!
    fileprivate let reuseIdentifier = "toolBarCell"
    var selectedIndex: Int! = 0
    
    
    
    
    weak var emoticonKeyBoardBottomToolBarDelegate: WXEmoticonBoardBottomToolBarDelegate?
    
    var dataSource  = [String]() {
        didSet{
            collectionView.reloadData()
            if dataSource.count != 0 {
                let indexPath = IndexPath(item: selectedIndex, section: 0)
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let a = WXEmoticonDataManager.sharedEmoticonDataMaganer
        print("单列2\(a)")
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(WXEmoticonKeyBoardBottomToolCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK:--对外的方法
extension WXEmoticonKeyBoardBottomTool {
    
    func emoticonKeyBoardBottomToolbar(scrollToIndex index:Int) {
    
        if selectedIndex! == index {
            
        } else {
            
            collectionView.selectItem(at:IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            selectedIndex = index
        
        }
    }
    
}

extension WXEmoticonKeyBoardBottomTool:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:reuseIdentifier, for: indexPath) as! WXEmoticonKeyBoardBottomToolCell
        cell.text = dataSource[indexPath.item]
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if dataSource.count == 0 {
            return CGSize.zero
        } else if dataSource.count < 4 {
            let width:CGFloat = UIScreen.main.bounds.width / CGFloat(dataSource.count) - 0.01
            let height = collectionView.frame.height
            let size = CGSize(width: width, height: height)
            return size
        } else {
            
            let width:CGFloat = 100 - 0.01
            let height = collectionView.frame.height
            let size = CGSize(width: width, height: height)
            return size

        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedIndex != indexPath.item {
            selectedIndex = indexPath.item
            emoticonKeyBoardBottomToolBarDelegate?.emoticonKeyBoardBottomTool(emoticonToolbar: self, didSelectItemAtIndex: indexPath.item)
            
        }
        
    }
    
    
}





