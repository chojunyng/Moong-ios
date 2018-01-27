//
//  KeywordCell.swift
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class KeywordCell: UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    
    var isCellSelected = false {
        didSet {
            if isCellSelected {
                self.isSelected = true
                self.backgroundColor = UIColor.init(hex: 0xffcd00)
                self.title.textColor = UIColor.white
            }
            else{
                self.isSelected = false
                self.backgroundColor = UIColor.white
                self.title.textColor = UIColor.init(hex: 0x4A4A4A)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = 15
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 15.0
    }
    
}
