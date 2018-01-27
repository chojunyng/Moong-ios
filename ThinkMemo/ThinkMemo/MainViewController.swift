//
//  MainViewController.swift
//  ThinkMemo
//
//  Created by 김재희 on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var MemoTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.MemoTableView.delegate = self
        self.MemoTableView.dataSource = self
        
        self.MemoTableView.separatorColor = UIColor.clear
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "MainBackground")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        MemoTableView.backgroundColor = UIColor.clear
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMemoCell") as! HeaderMemoCell
        cell.titleImage.image = UIImage(named: "MainTitleImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell") as! MemoCell
        cell.backgroundColor = UIColor.clear
        if (indexPath.row == 2) {
            cell.contentLabel.text = "정리된 말 정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말"
            cell.dateLabel.text = "2018.01.25"
            cell.shadowLabel.text = "생각 정리가 필요해요 !"
            let g = UITapGestureRecognizer()
            cell.cardView.addGestureRecognizer(g)
        }
        else {
            cell.contentLabel.text = "정리된 말 정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말정리된 말"
            cell.dateLabel.text = "2018.01.25"
            cell.shadowView.isHidden = true
            cell.shadowLabel.isHidden = true
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    
    
    
}









