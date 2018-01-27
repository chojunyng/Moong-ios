//
//  DetailViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
//        titleLabel.text = ""
        
        return titleLabel
    }()
    
    private lazy var keywordButton: UIButton = {
        let keywordButton = UIButton(type: .system)
        keywordButton.setTitle("K", for: .normal)
        
        return keywordButton
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("D", for: .normal)
        
        return deleteButton
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
//        dateLabel.text = ""
        
        return dateLabel
    }()
    
    private lazy var resultTextView: UITextView = {
        let resultTextView = UITextView()
        resultTextView.isEditable = false
//        resultLabel.text = ""
        
        return resultTextView
    }()
    
    private lazy var keywordsLabel: UILabel = {
        let keywordsLabel = UILabel()
        
        return keywordsLabel
    }()
    
    private lazy var contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.isEditable = false
        
        return contentTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController {
//    private func titleLabelConstraints() -> [NSLayoutConstraint] {
//
//    }
    
    private func dateLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: dateLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    
}
