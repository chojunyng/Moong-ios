//
//  CompleteCombineVC.swift
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class CompleteCombineVC: UIViewController {
    
    
    var keywords = [String]()
    var contents : String?
    var data = MemoData()
    lazy var dao = MemoDAO()
    
    
    @IBOutlet var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 30
            containerView.layer.backgroundColor = UIColor.white.cgColor
            containerView.layer.shadowColor = UIColor.darkGray.cgColor
            containerView.layer.masksToBounds = false
            containerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
            containerView.layer.shadowOpacity = 0.1
            containerView.layer.shadowRadius = 30
        }
    }
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var textView: UITextView!
    @IBAction func storeAction(_ sender: Any) {
        data.keywords = keywords
        data.result = contents
        
        dao.update(data: data)
        
        print("완료")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textView.text = contents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
