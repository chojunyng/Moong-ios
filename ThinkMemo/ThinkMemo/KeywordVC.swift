//
//  KeywordVC
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class KeywordVC : UIViewController {
    
    @IBOutlet var keywordColvw: UICollectionView! {
        didSet {
            keywordColvw.delegate = self
            keywordColvw.dataSource = self
            keywordColvw.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: "KeywordCell")
        }
    }
    
    var _selectedCells = NSMutableArray()
    var keywords = [String]()
    let reuseIdentifier = "KeywordCell"
    
    var isCellSelected = false {
        didSet {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        keywordColvw.allowsMultipleSelection = true
    }

}

extension KeywordVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = keywordColvw.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KeywordCell
        
        if _selectedCells.contains(indexPath) {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)

            cell.isSelected = true
            cell.backgroundColor = UIColor.init(hex: 0xffcd00)
            cell.title.textColor = UIColor.white
        }
        else{
            cell.isSelected = false
            cell.backgroundColor = UIColor.white
            cell.title.textColor = UIColor.init(hex: 0x4A4A4A)
        }
        
        return cell
    }
    
    // select, deselect cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard _selectedCells.count < 3 else { return }
        _selectedCells.add(indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        _selectedCells.remove(indexPath)
        collectionView.reloadItems(at: [indexPath])

    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//
//
//        print("yes")
//    }
    
}

extension KeywordVC : UICollectionViewDelegate {
    
}

extension KeywordVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard collectionViewLayout is UICollectionViewFlowLayout else {
            return .zero
        }
        
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        
        if cellCount > 0 {
//            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
//
//            let totalCellWidth = cellWidth * cellCount
//            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right - flowLayout.headerReferenceSize.width - flowLayout.footerReferenceSize.width
//
//            if (totalCellWidth < contentWidth) {
//                let padding = (contentWidth - totalCellWidth + flowLayout.minimumInteritemSpacing) / 2.0
//                return UIEdgeInsetsMake(0, padding, 0, 0)
//            }
            
            return UIEdgeInsetsMake(26, 128.5, 0, 128.5)
        }
        
        return .zero
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
