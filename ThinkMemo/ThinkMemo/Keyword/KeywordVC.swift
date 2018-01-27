//
//  KeywordVC
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class KeywordVC : UIViewController {
    
    // 앱 델리게이트 객체의 참조 정보를 읽어온다
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var keywords = [String]()
    
    @IBOutlet var keywordColvw: UICollectionView! {
        didSet {
            keywordColvw.delegate = self
            keywordColvw.dataSource = self
            keywordColvw.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
    
    let reuseIdentifier = "KeywordCell"
    let MaximumNumberOfTaps = 3
    var selectedCells = NSMutableArray()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordColvw.allowsMultipleSelection = true
        
        /*
        if keywords.isEmpty {
            print(keywords)
            if let data = appDelegate.memolist.first {
                print(data)
                keywords = data.keywords
            }
        }
        */
        print(keywords)
    }

}

extension KeywordVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = keywordColvw.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KeywordCell
        
        cell.isCellSelected = selectedCells.contains(indexPath)
        
        return cell
    }
    
    // select, deselect cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedCells.count < MaximumNumberOfTaps else { return }
        selectedCells.add(indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedCells.remove(indexPath)
        collectionView.reloadItems(at: [indexPath])

    }
}

extension KeywordVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard collectionViewLayout is UICollectionViewFlowLayout else {
            return .zero
        }
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        
        return cellCount > 0 ? UIEdgeInsetsMake(26, 128.5, 0, 128.5) : .zero
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
