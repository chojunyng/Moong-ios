//
//  NewMemoViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class NewMemoViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet var memoView: UITextView! {
        didSet {
            memoView.delegate = self
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10
            let attributes = [NSAttributedStringKey.paragraphStyle : style]
            memoView.attributedText = NSAttributedString(string: memoView.text,
                                                         attributes: attributes)
        }
    }
    
    // MARK: Methods
    
    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelButtonDidTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        memoView.tintColor = UIColor(red: 3.0/255.0,
                                     green: 3.0/255.0,
                                     blue: 3.0/255.0,
                                     alpha: 1.0)
        memoView.becomeFirstResponder()
    }
}


extension NewMemoViewController: UITextViewDelegate {
    
    // TextView Delegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let replacementCount = textView.text.count + text.count
        if replacementCount > 400 { return false }
        else { return true }
    }
}
