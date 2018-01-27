//
//  DetailEndVC.swift
//  ThinkMemo
//
//  Created by BLU on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class DetailEndVC: UIViewController {

    let reuseidentifier = "KeywordCell"
    
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
    
    @IBOutlet var wordsColvw: UICollectionView! {
        didSet {
            wordsColvw.delegate = self
            wordsColvw.dataSource = self
            wordsColvw.register(UINib(nibName: "KeywordCell", bundle: nil), forCellWithReuseIdentifier: reuseidentifier)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DetailEndVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        
        if indexPath.item == 1 {
            return CGSize(width: 111, height: 30)
        }
        return CGSize(width: 86, height: 30)
    }
}



extension DetailEndVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wordsColvw.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        cell.backgroundColor = UIColor.init(hex: 0xffcd00)
        
        return cell
    }
}
