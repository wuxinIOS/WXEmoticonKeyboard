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


@objc protocol WXEmoticonKeyBoardDelegate:NSObjectProtocol {
    
    @objc optional func emoticonKeyBoard(_ emoticonKeyBoard:WXEmoticonKeyBoard,selectedEmotion:Any,selectedID:String)
    @objc optional func emoticonKeyBoard(_ emoticonKeyBoard:WXEmoticonKeyBoard,delectedEmotion:Any,deleteID:String?)
}

class WXEmoticonKeyBoard: UIView {
    
        //MARK:--表情键盘单例
    static let sharedEmoticonKeyBoard =  WXEmoticonKeyBoard(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216))
    
    //固定高度设置
    let emoticonKeyBardHeight:CGFloat! = 216
    let pageControlHeight:CGFloat! = 15
    let bottomToolBarHeight:CGFloat! = 40
    let emoticonMainCollectionViewHeight:CGFloat! = 161
    
    
    weak var emoticonKeyBoardDelegate:WXEmoticonKeyBoardDelegate?
    
    lazy var dataSource:[String] = {
        
        var string = [String]()
        for emoticonPackage in WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageArray {
            let name = emoticonPackage.group_name_cn
            string.append(name!)
            
        }
        return string
        
    }()
    
    
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
        setupCollectionView()
        setupPageControl()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.backgroundColor = UIColor.lightGray
        addSubview(view)
        
        let view1 = UIView(frame: CGRect(x: 0, y: self.bounds.height - 1, width: UIScreen.main.bounds.width, height: 1))
        view1.backgroundColor = UIColor.lightGray
        addSubview(view1)
        
    }
    
    
    
    //MARK:--初始化表情主界面collectionView
    fileprivate func setupCollectionView(){
        //FIXME:--修改表情主视图的cell的个数
        let countArray = WXEmoticonDataManager.sharedEmoticonDataMaganer.numberOfItem(3, 7)
        emoticonMainCollectionView = WXEmoticonCollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: emoticonMainCollectionViewHeight), section: countArray)
        
        emoticonMainCollectionView.emoticonCollectionViewDelegate = self
        
        addSubview(emoticonMainCollectionView)
        
    }
    
    //MARK:--初始化pageControl控件
    fileprivate func setupPageControl(){
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y:  emoticonMainCollectionViewHeight, width: UIScreen.main.bounds.width, height: pageControlHeight))
        pageControl.numberOfPages = WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageGroupArray[0]
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.isUserInteractionEnabled = false
        pageControl.backgroundColor = UIColor.white
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
extension WXEmoticonKeyBoard:WXEmoticonBoardBottomToolBarDelegate,WXEmoticonCollectionViewDelegate {
    func emoticonKeyBoardBottomTool(emoticonToolbar: WXEmoticonKeyBoardBottomTool, didSelectItemAtIndex index: Int) {
        
        //print("点击了第\(index)个----\(emoticonKeyBoardTool.dataSource[index])")
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
        pageControl.numberOfPages = WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageGroupArray[indexPath.section]
        pageControl.currentPage = indexPath.item
        pageControl.updateCurrentPageDisplay()
        
    }
    
    //删除
    func emoticonCollectionView(_ collectionView: WXEmoticonCollectionView, deleteDefaultEmoticon: WXEmoticonModel?, deleteEmojiEmoticon: WXEmoticonEmojiModel?) {
        if let delegate = emoticonKeyBoardDelegate {
            if delegate.responds(to: #selector(WXEmoticonKeyBoardDelegate.emoticonKeyBoard(_:delectedEmotion:deleteID:))) {
                
                
                delegate.emoticonKeyBoard!(self, delectedEmotion: deleteEmojiEmoticon?.emoji ?? "",deleteID:nil)
                
                
                
            }
        }
        
    }
    
    func emoticonCollectionView(_ collectionView: WXEmoticonCollectionView, selectDefaultEmoticon: WXEmoticonModel?, selectEmojiEmoticon: WXEmoticonEmojiModel?) {
        
        if let delegate = emoticonKeyBoardDelegate {
            if delegate.responds(to: #selector(WXEmoticonKeyBoardDelegate.emoticonKeyBoard(_:selectedEmotion:selectedID:))) {
                if let emoticon = selectDefaultEmoticon{//默认的包
                    let package = WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageArray[0]
                    let emoticon = (emoticon.chs ?? "",emoticon.cht ?? "",emoticon.pngPath ?? "")
                    delegate.emoticonKeyBoard!(self, selectedEmotion: emoticon,selectedID:package.id!)
                } else {//emoji包
                    let package = WXEmoticonDataManager.sharedEmoticonDataMaganer.emoticonPackageArray[1]
                    
                    delegate.emoticonKeyBoard!(self, selectedEmotion: selectEmojiEmoticon?.emoji ?? "", selectedID: package.id!)
                }
            }
        }

    }
    
}












