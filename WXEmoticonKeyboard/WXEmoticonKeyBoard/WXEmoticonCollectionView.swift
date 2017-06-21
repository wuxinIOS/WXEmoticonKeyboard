//
//  WXEmoticonCollectionView.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/21.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

@objc protocol WXEmoticonCollectionViewScrollDelegate:NSObjectProtocol {
    
    func emoticonCollectionView(_ collectionView:WXEmoticonCollectionView,scrollToIndexPaht indexPath:IndexPath)
    
}



class WXEmoticonCollectionView: UICollectionView {

    
    weak var emoticonCollectionViewScrollDelegate: WXEmoticonCollectionViewScrollDelegate?
    
    var lastIndexPath:IndexPath! = IndexPath(item: 0, section: 0)
    
    var numberSection : Int! {
        
        didSet{
            self.reloadData()
        }
    }

    
    convenience init(frame:CGRect,section:Int){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.init(frame: frame, collectionViewLayout: layout)
        numberSection = section
        backgroundColor = UIColor.white
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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

extension WXEmoticonCollectionView:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        var label = cell.viewWithTag(1) as? UILabel
        
        if let _ = label {
            
        } else {
            
            label = UILabel(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        }
        
        label!.text = "\(indexPath.section)-\(indexPath.item)"

        label!.tag = 1
        cell.addSubview(label!)
        
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
        
    }
    
    
    //滚动停止
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      
        
        let indexPath = self.indexPathForItem(at: scrollView.contentOffset)
        
        if let delegate =  emoticonCollectionViewScrollDelegate,
            let indexPath = indexPath {
            
            if delegate.responds(to: #selector(WXEmoticonCollectionViewScrollDelegate.emoticonCollectionView(_:scrollToIndexPaht:))) {
                
                delegate.emoticonCollectionView(self, scrollToIndexPaht: indexPath)
            }
            
        }
        
    }
    
    
    
    
}



