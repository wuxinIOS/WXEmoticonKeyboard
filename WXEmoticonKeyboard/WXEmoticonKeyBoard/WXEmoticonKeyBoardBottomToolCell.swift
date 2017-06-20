//
//  WXEmoticonKeyBoardBottomToolCell.swift
//  WXEmoticonKeyboard
//
//  Created by BlackEr Gray on 17/6/20.
//  Copyright © 2017年 BlackEr Gray. All rights reserved.
//

import UIKit

class WXEmoticonKeyBoardBottomToolCell: UICollectionViewCell {
    
    private var titleLabel: UILabel!
    private var selectedBackground: UIView!
    
    var text: String? {
        didSet{
            
            titleLabel.text = text
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: self.bounds)
        titleLabel.backgroundColor = UIColor.white
        titleLabel.text = text
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 1)
        backgroundView = titleLabel
        
        selectedBackground = UIView(frame: self.bounds)
        selectedBackground.backgroundColor = UIColor(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 0.3)
        selectedBackgroundView = selectedBackground
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
