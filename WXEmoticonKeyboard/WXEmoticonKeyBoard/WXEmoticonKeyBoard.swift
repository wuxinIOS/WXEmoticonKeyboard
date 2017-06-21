//
//  WXEmoticonKeyBoard.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/20.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//   表情键盘视图(单例)
/**
     整个表情键盘的高度为：216 = (分页控制器的高度为：10) + (底部工具条的高度为: 40) + (显示表情符号的主视图:166)
  */

import UIKit

class WXEmoticonKeyBoard: UIView {
    
        //MARK:--表情键盘单例
    static let sharedEmoticonKeyBoard =  WXEmoticonKeyBoard(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))
    
    //固定高度设置
    let emoticonKeyBardHeight:CGFloat! = 216
    let pageControlHeight:CGFloat! = 15
    let bottomToolBarHeight:CGFloat! = 40
    let emoticonMainCollectionViewHeight:CGFloat! = 161
    var dataSource = ["最近使用","默认","Emoji","自定义","下载","收藏"]
    
        //MARK:--表情键盘底部分类工具条
    var emoticonKeyBoardTool : WXEmoticonKeyBoardBottomTool!
    
        //MARK:--表情显示主视图
    var emoticonMainCollectionView: WXEmoticonCollectionView!
    
        //MARK:--分页控制器
    var pageControl: UIPageControl!
    
    //MARK:--记录上一次选中的工具条的index
    var lastSelectedToolBarIndex:Int! = 0
    
    private override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:--初始化UI
extension WXEmoticonKeyBoard {
    
    fileprivate func setupUI() {
        setupBottomTool()
        setupPageControl()
        setupCollectionView()
    }
    
    
    
    //MARK:--初始化表情主界面collectionView
    fileprivate func setupCollectionView(){
        
        emoticonMainCollectionView = WXEmoticonCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: emoticonMainCollectionViewHeight), section: dataSource.count)
        emoticonMainCollectionView.emoticonCollectionViewScrollDelegate = self
        
        addSubview(emoticonMainCollectionView)
        
    }
    
    //MARK:--初始化pageControl控件
    fileprivate func setupPageControl(){
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y:  emoticonMainCollectionViewHeight, width: UIScreen.main.bounds.width, height: pageControlHeight))
        pageControl.numberOfPages = dataSource.count
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
    }
    
    
    
    //MARK:--底部工具条
    fileprivate func setupBottomTool() {
        
        emoticonKeyBoardTool = WXEmoticonKeyBoardBottomTool(frame: CGRect(x: 0, y: self.frame.height - bottomToolBarHeight , width: UIScreen.main.bounds.width, height: bottomToolBarHeight))
        emoticonKeyBoardTool.emoticonKeyBoardBottomToolBarDelegate = self
        emoticonKeyBoardTool.dataSource = dataSource
        addSubview(emoticonKeyBoardTool)
        
    }
}


//MARK:--和协议相关
extension WXEmoticonKeyBoard:WXEmoticonBoardBottomToolBarDelegate,WXEmoticonCollectionViewScrollDelegate {
    func emoticonKeyBoardBottomTool(emoticonToolbar: WXEmoticonKeyBoardBottomTool, didSelectItemAtIndex index: Int) {
        
        print("点击了第\(index)个----\(emoticonKeyBoardTool.dataSource[index])")
        let indextPaht = IndexPath(item: 0, section: index)
        
        emoticonMainCollectionView.scrollToItem(at: indextPaht, at: .right, animated: false)
        
        emoticonCollectionView(emoticonMainCollectionView, scrollToIndexPaht: indextPaht)
        
    }
   
    //显示表情主界面的collectionView的代理
    func emoticonCollectionView(_ collectionView: WXEmoticonCollectionView, scrollToIndexPaht indexPath: IndexPath) {
        
        
        if lastSelectedToolBarIndex == indexPath.section {

        } else {
            
            emoticonKeyBoardTool.emoticonKeyBoardBottomToolbar(scrollToIndex:indexPath.section)
            lastSelectedToolBarIndex = indexPath.section
        }
        
        pageControl.currentPage = indexPath.item
        
        
        
    }
    
    
}












