//
//  EditMemoViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class EditMemoViewController: UIViewController {
    
    // MARK: Properties
    
    // 앱 델리게이트 객체의 참조 정보를 읽어온다
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    var subject: String!
    lazy var dao = MemoDAO()
    
    var editText: String!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet private var textCountLabel: UILabel!
    @IBOutlet var memoView: UITextView! {
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
//        // MemoData 객체를 생성하고, 데이터를 담는다.
//        let data = MemoData()
//
//        data.title = subject
//        data.content = memoView.text
//        data.regdate = Date()
//
//        // 코어 데이터에 메모 데이터를 추가한다.
//        dao.insert(data)
//
//
//        
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        if let detailViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//
//            self.view.endEditing(true)
//            detailViewController.data = data
//            UIApplication.shared.keyWindow?.rootViewController = detailViewController
//        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoView.text = editText
        memoView.tintColor = UIColor(red: 3.0/255.0,
                                     green: 3.0/255.0,
                                     blue: 3.0/255.0,
                                     alpha: 1.0)
        memoView.becomeFirstResponder()
    }
}


extension EditMemoViewController: UITextViewDelegate {
    
    // TextView Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let currentCount = textView.text.count
        textCountLabel.text = "(\(currentCount)/400)자"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let replaceCount = textView.text.count + text.count - range.length
        
        if replaceCount == 0 {
            saveButton.isEnabled = false
            saveButton.alpha = 0.5
        } else {
            saveButton.isEnabled = true
            saveButton.alpha = 1.0
        }
        
        if replaceCount < 400 {
            textCountLabel.text = "(\(replaceCount)/400)자"
        } else {
            textCountLabel.text = "(400/400)자"
        }
        
        if replaceCount > 400 { return false }
        else { return true }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 20자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ((contents.length > 20) ? 20 : contents.length)
        subject = contents.substring(with: NSRange(location: 0, length: length))
    }
}

