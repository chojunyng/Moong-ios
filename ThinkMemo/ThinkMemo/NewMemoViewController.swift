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
    
    @IBOutlet private var textCountLabel: UILabel!
    @IBOutlet private var memoView: UITextView! {
        didSet {
            memoView.delegate = self
            
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 10.0
            let attributes = [NSAttributedStringKey.paragraphStyle: style]
            memoView.attributedText = NSAttributedString(string: memoView.text,
                                                         attributes: attributes)
        }
    }
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction private func cancelButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func saveButtonDidTapped(_ sender: UIButton) {
        
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
        
        let replaceCount = textView.text.count + text.count - range.length
        
        if replaceCount < 400 {
            textCountLabel.text = "(\(replaceCount)/400)자"
        } else {
            textCountLabel.text = "(400/400)자"
        }
        
        if replaceCount > 400 { return false }
        else { return true }
    }
}
