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

    @IBOutlet private var doneButton: UIButton! {
        didSet {
            doneButton.layer.borderWidth = 1.0
            doneButton.layer.borderColor = UIColor(red: 1.0,
                                                   green: 205.0/255.0,
                                                   blue: 0.0, alpha: 1.0).cgColor
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
