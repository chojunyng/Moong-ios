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
    
    var keywords = [String]()
    var data = MemoData()
    
    
    @IBOutlet var wordsColvw: UICollectionView! {
        didSet {
            wordsColvw.delegate = self
            wordsColvw.dataSource = self
            wordsColvw.register(UINib(nibName: "KeywordCell", bundle: nil), forCellWithReuseIdentifier: reuseidentifier)
            
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
    
    @IBAction func backButtonDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextButtonDidTapped(_ sender: Any) {
        if let combineWordsVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteCombineVC") as? CompleteCombineVC {
            
           combineWordsVC.contents = textView.text
           combineWordsVC.data = data
            combineWordsVC.keywords = keywords
            
            self.navigationController?.pushViewController(combineWordsVC, animated: true)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(tapGesture)
        
        textView.tintColor = UIColor(red: 72.0/255.0, green: 79.0/255.0, blue: 77.0/255.0, alpha: 1.0)
        textView.becomeFirstResponder()
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



extension CombineWordsVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wordsColvw.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        cell.backgroundColor = UIColor.init(hex: 0xffcd00)
        cell.title.textColor = .white
        cell.title.text = keywords[indexPath.item]
        return cell
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

