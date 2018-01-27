//
//  CombineViewController
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class CombineWordsVC: UIViewController {
    
    @IBOutlet var clearTextView: UITextView! {
        didSet {
            clearTextView.layer.cornerRadius = 30
            clearTextView.layer.backgroundColor = UIColor.white.cgColor
            clearTextView.layer.shadowColor = UIColor.darkGray.cgColor
            clearTextView.layer.masksToBounds = false
            clearTextView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
            clearTextView.layer.shadowOpacity = 0.1
            clearTextView.layer.shadowRadius = 30
        }
    }
    
    @IBOutlet var wordsColvw: UICollectionView! {
        didSet {
            wordsColvw.dataSource = self
            wordsColvw.register(UINib(nibName: "KeywordCell", bundle: nil), forCellWithReuseIdentifier: "KeywordCell")
        }
    }
    
    var keywords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CombineWordsVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 24
        let attributes : [NSAttributedStringKey : Any] = [
            .paragraphStyle : style,
            .font: UIFont(name: "Papya", size:20) ?? UIFont.systemFont(ofSize: 20)
        ]
        textView.attributedText = NSAttributedString(string: textView.text, attributes: attributes)
    }
}
//extension CombineWordsVC : UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        return newText.count <= 30
//    }
//}

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

