//
//  MemoCell.swift
//  ThinkMemo
//
//  Created by 김재희 on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

import UIKit
class MemoCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var shadowButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.layer.cornerRadius = 12
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.layer.shadowColor = UIColor.darkGray.cgColor
        cardView.layer.masksToBounds = false
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowRadius = 12.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

