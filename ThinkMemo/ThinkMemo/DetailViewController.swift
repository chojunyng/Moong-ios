//
//  DetailViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.titleLabel?.textColor = UIColor(red: 1.0, green: 198.0/255.0, blue: 0.0, alpha: 1.0)
        deleteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTapped(_:)), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return deleteButton
    }()
    
    private lazy var resultBaseView: UIView = {
        let resultBaseView = UIView()
        resultBaseView.layer.cornerRadius = 10.0
        
        resultBaseView.layer.backgroundColor = UIColor.white.cgColor
        resultBaseView.layer.shadowColor = UIColor.darkGray.cgColor
        resultBaseView.layer.masksToBounds = false
        resultBaseView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        resultBaseView.layer.shadowOpacity = 0.1
        resultBaseView.layer.shadowRadius = 10.0
        
        resultBaseView.translatesAutoresizingMaskIntoConstraints = false
        
        return resultBaseView
    }()
    
    private lazy var resultTextView: UITextView = {
        let resultTextView = UITextView()
        resultTextView.text = "정리된 말 정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말"
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        let attributes = [NSAttributedStringKey.paragraphStyle: style,
                          NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Regular",
                                                             size: 15.0)]
        resultTextView.attributedText = NSAttributedString(string: resultTextView.text,
                                                            attributes: attributes)
        
        
        resultTextView.isEditable = false
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return resultTextView
    }()
    
    private lazy var keywordsCollectionView: UICollectionView = {
        let keywordsCollectionView = UICollectionView()
        
        return keywordsCollectionView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    private lazy var contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.text = "안녕하세요. 글을 쓰는 중입니다. 안녕하세요. 글을 쓰는 중입니다. 안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요. 글을 쓰는 중입니다.안녕하세요."
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        let attributes = [NSAttributedStringKey.paragraphStyle: style,
                          NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Regular",
                                                             size: 16.0)]
        contentTextView.attributedText = NSAttributedString(string: contentTextView.text,
                                                            attributes: attributes)
        
        contentTextView.isEditable = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentTextView
    }()
    
    private lazy var keywordButton: UIButton = {
        let keywordButton = UIButton(type: .system)
        keywordButton.setTitle("생각 정리하기", for: .normal)
        keywordButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20.0)
        keywordButton.tintColor = .white
        keywordButton.backgroundColor = UIColor(red: 1.0, green: 205.0/255.0, blue: 0.0, alpha: 1.0)
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        
        return keywordButton
    }()
    
    // MARK: Methods
    
    @objc private func deleteButtonDidTapped(_ sender: UIButton) {
        if let deleteMemoViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeleteMemoViewController") as? DeleteMemoViewController {
            
            deleteMemoViewController.modalPresentationStyle = .overCurrentContext
            self.present(deleteMemoViewController, animated: false, completion: nil)
        }
    }

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(deleteButton)
        self.view.addConstraints(deleteButtonConstraints())

//        self.view.addSubview(resultBaseView)
//        self.view.addConstraints(resultBaseViewConstraints())
//        self.view.addSubview(resultTextView)
//        self.view.addConstraints(resultTextViewConstraints())
//        self.view.addSubview(divisionView)
//        self.view.addConstraints(divisionViewConstraints())
        
        self.view.addSubview(contentTextView)
        if resultBaseView.isDescendant(of: self.view) {
            self.view.addConstraints(contentTextViewYesResultConstraints())
        } else {
            self.view.addConstraints(contentTextViewNoResultConstraints())
        }

        if !resultBaseView.isDescendant(of: self.view) {
            self.view.addSubview(keywordButton)
            self.view.addConstraints(keywordButtonConstraints())
        }
    }
}

extension DetailViewController {
    private func deleteButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: deleteButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint]
    }
    
    private func resultBaseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 104.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 321.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 111.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func resultTextViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .centerY, relatedBy: .equal,
            toItem: resultBaseView, attribute: .centerY, multiplier: 1.0, constant: 10.0)
        let centerXConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .centerX, relatedBy: .equal,
            toItem: resultBaseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .width, relatedBy: .equal,
            toItem: resultBaseView, attribute: .width, multiplier: 0.9, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .height, relatedBy: .equal,
            toItem: resultBaseView, attribute: .height, multiplier: 0.9, constant: 0.0)
        
        return [centerYConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func keywordsStackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: keywordsCollectionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 238.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: keywordsCollectionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: keywordsCollectionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 299.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: keywordsCollectionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 30.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 312.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 301.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 2.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func contentTextViewNoResultConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 89.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 303.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 350.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func contentTextViewYesResultConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 339.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 303.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 350.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func keywordButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -54.0)
        let leadingConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
