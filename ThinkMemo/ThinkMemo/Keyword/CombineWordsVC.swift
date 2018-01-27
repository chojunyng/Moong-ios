//
//  CombineViewController
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class CombineWordsVC: UIViewController {
    
    let reuseidentifier = "KeywordCell"
    
    @IBOutlet var wordsColvw: UICollectionView! {
        didSet {
            wordsColvw.delegate = self
            wordsColvw.dataSource = self
            wordsColvw.register(UINib(nibName: "KeywordCell", bundle: nil), forCellWithReuseIdentifier: reuseidentifier)
            
        }
    }
    @IBOutlet var backButton: UIButton! {
        didSet {
            backButton.addTarget(self,
                                 action: #selector(popToKeywordVC),
                                 for: .touchUpInside)
        }
    }
    
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
    @IBOutlet var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    
    @IBOutlet var textCountLabel: UILabel!
    
    let tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(keyboardWillHide)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension CombineWordsVC {
    @objc func keyboardWillHide() {
        self.textView.endEditing(true)
    }
    @objc func popToKeywordVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
extension CombineWordsVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        if indexPath.item == 1 {
            return CGSize(width: 111, height: 30)
        }
        return CGSize(width: 86, height: 30)
    }
}

extension CombineWordsVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textCountLabel.text = "(" + String(textView.text.count) + "/60)자"
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 60
    }
}

extension CombineWordsVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wordsColvw.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        cell.backgroundColor = UIColor.init(hex: 0xffcd00)
        
        return cell
    }
}

