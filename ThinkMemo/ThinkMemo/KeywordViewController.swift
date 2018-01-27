//
//  KeywordViewController.swift
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class KeywordViewController : UIViewController {
    
    @IBOutlet var keywordColvw: UICollectionView! {
        didSet {
            keywordColvw.delegate = self
            keywordColvw.dataSource = self
            keywordColvw.allowsMultipleSelection = true
            
        }
    }
    
    var selectedCells : NSMutableArray = []
    var keywords : [String] = []
    let reuseIdentifier = "KeywordCell"
    
//    var isCellSelected: Bool {
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension KeywordViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = keywordColvw.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! KeywordCell
        cell.layer.cornerRadius = 10
        
        if selectedCells.contains(indexPath) {
            cell.isSelected = true
            cell.checkImage.isHidden = false
        }
        else{
            cell.isSelected = false
            cell.checkImage.isHidden = true
        }
        
        return cell
    }
    
    // select, deselect cells
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("NO")
        selectedCells.add(indexPath)
        keywordColvw.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedCells.remove(indexPath)
        keywordColvw.reloadItems(at: [indexPath])
    }
    
}

extension KeywordViewController : UICollectionViewDelegate {
    
}
