//
//  MainViewController.swift
//  ThinkMemo
//
//  Created by 김재희 on 2018. 1. 28..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    var memolist = (UIApplication.shared.delegate as! AppDelegate).memolist
    let dao = MemoDAO()
    
    @IBOutlet weak var MemoTableView: UITableView!
    
    // MARK: Methods
    
    @IBAction func memoCreateButtonDidTapped(_ sender: UIButton) {
        let newMemoStoryboard = UIStoryboard(name: "NewMemo", bundle: nil)
        if let newMemoViewController = newMemoStoryboard.instantiateInitialViewController() as? NewMemoViewController {
            
            self.present(newMemoViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: Life Cycle
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memolist = dao.fetch()
        MemoTableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Custom Methods
    
    @objc private func cellDidTapped(_ sender: UIButton) {
        let data = memolist[sender.tag]
        
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.data = data
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    // MARK: Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memolist.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMemoCell") as! HeaderMemoCell
        cell.titleImage.image = UIImage(named: "MainTitleImage")
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell") as! MemoCell
        cell.backgroundColor = UIColor.clear
        cell.isUserInteractionEnabled = true
        
        cell.contentLabel.text = memolist[indexPath.row].content
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let regdate = memolist[indexPath.row].regdate {
            let writeDate = dateFormatter.string(from: regdate)
            cell.dateLabel.text = "\(writeDate)"
        }
        
        if let _ = memolist[indexPath.row].result {
            cell.shadowButton.isHidden = true
            cell.shadowView.isHidden = true
            cell.selectionStyle = .none
        } else {
            tableView.allowsSelection = false
            cell.shadowButton.addTarget(self,
                                        action: #selector(cellDidTapped(_:)),
                                        for: .touchUpInside)
            cell.shadowButton.tag = indexPath.row
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = memolist[indexPath.row]
        
        if let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            
            detailViewController.data = data
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
}
