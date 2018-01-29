//
//  KeywordErrorViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class KeywordErrorViewController: UIViewController {

    @IBAction func backgroundDidTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
