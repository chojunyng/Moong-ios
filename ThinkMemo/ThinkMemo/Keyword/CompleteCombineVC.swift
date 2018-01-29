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
    
    
    @IBOutlet var containerView: UIView!
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var textView: UITextView!
//        didSet {
//            let style = NSMutableParagraphStyle()
//            style.lineSpacing = 10.0
//            let attributes = [NSAttributedStringKey.paragraphStyle: style,
//                              NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Regular",
//                                                                 size: 15.0)]
//            textView.attributedText = NSAttributedString(string: textView.text,
//                                                              attributes: attributes)
//        }
//    }
    @IBAction func storeAction(_ sender: Any) {
        data.keywords = keywords
        data.result = contents
        
        dao.update(data: data)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = mainStoryboard.instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = mainViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        textView.text = contents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.masksToBounds = false
        containerView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 30
        
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
