//
//  DeleteMemoViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class DeleteMemoViewController: UIViewController {
    
    // MARK: Properties

    // 앱 델리게이트 객체의 참조 정보를 읽어온다
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var data = MemoData()
    var removeIdx = 0
    
    lazy var dao = MemoDAO()
    
    @IBOutlet private var doneButton: UIButton! {
        didSet {
            doneButton.addTarget(self, action: #selector(doneButtonDidTapped(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet private var cancelButton: UIButton! {
        didSet {
            cancelButton.addTarget(self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: Methods
    
    @IBAction private func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func doneButtonDidTapped(_ sender: UIButton) {
        
        if dao.delete(data.objectID!) {
            appDelegate.memolist.remove(at: removeIdx)
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
    }
}
