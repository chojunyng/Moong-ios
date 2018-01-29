//
//  DetailViewController.swift
//  ThinkMemo
//
//  Created by JUN LEE on 2018. 1. 27..
//  Copyright © 2018년 Unithon. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "KeywordCell", bundle: nil), forCellWithReuseIdentifier: "KeywordCell")
        }
    }
    
    // MARK: Properties
 
    lazy var dao = MemoDAO()
    var data = MemoData()
    var removeIdx = 0
    
    // 앱 델리게이트 객체의 참조 정보를 읽어온다
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
//    var timer: Timer!
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if let regdate = data.regdate {
            let writeDate = dateFormatter.string(from: regdate)
            titleLabel.text = "\(writeDate)"
        }
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17.0)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "backBtn"), for: .normal)
        backButton.tintColor = UIColor(red: 1.0, green: 205.0/255.0, blue: 0.0, alpha: 1.0)
        backButton.addTarget(self, action: #selector(backButtonDidTapped(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        return backButton
    }()
    
    private lazy var editButton: UIButton = {
        let editButton = UIButton(type: .system)
        editButton.setBackgroundImage(#imageLiteral(resourceName: "edit"), for: .normal)
        editButton.tintColor = UIColor(red: 1.0, green: 198.0/255.0, blue: 0.0, alpha: 1.0)
//        editButton.addTarget(self, action: #selector(editButtonDidTapped(_:)), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        return editButton
    }()

    private lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .system)
        deleteButton.setBackgroundImage(#imageLiteral(resourceName: "delete"), for: .normal)
        deleteButton.tintColor = UIColor(red: 1.0, green: 198.0/255.0, blue: 0.0, alpha: 1.0)
        deleteButton.addTarget(self, action: #selector(deleteButtonDidTapped(_:)), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        return deleteButton
    }()
    
    private lazy var resultBaseView: UIView = {
        let resultBaseView = UIView()
        resultBaseView.layer.cornerRadius = 10.0
        
        resultBaseView.layer.backgroundColor = UIColor.white.cgColor
        resultBaseView.layer.shadowColor = UIColor.darkGray.cgColor
        resultBaseView.layer.masksToBounds = false
        resultBaseView.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        resultBaseView.layer.shadowOpacity = 0.1
        resultBaseView.layer.shadowRadius = 10.0
        
        resultBaseView.translatesAutoresizingMaskIntoConstraints = false
        
        return resultBaseView
    }()
    
    private lazy var resultTextView: UITextView = {
        let resultTextView = UITextView()
        resultTextView.text = data.result

        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        let attributes = [NSAttributedStringKey.paragraphStyle: style,
                          NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Regular",
                                                             size: 15.0)]
        resultTextView.attributedText = NSAttributedString(string: resultTextView.text,
                                                            attributes: attributes)
        
        
        resultTextView.isEditable = false
        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return resultTextView
    }()
    

    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        return flowLayout
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    private lazy var contentTextView: UITextView = {
        let contentTextView = UITextView()
        
        contentTextView.text = data.content!
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10.0
        let attributes = [NSAttributedStringKey.paragraphStyle: style,
                          NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Regular",
                                                             size: 16.0)]
        contentTextView.attributedText = NSAttributedString(string: contentTextView.text,
                                                            attributes: attributes)
        
        contentTextView.isEditable = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentTextView
    }()
    
    private lazy var keywordButton: UIButton = {
        let keywordButton = UIButton(type: .system)
        keywordButton.setTitle("생각 정리하기", for: .normal)
        keywordButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20.0)
        keywordButton.tintColor = .white
        keywordButton.backgroundColor = UIColor(red: 0.0, green: 163.0/255.0, blue: 190.0/255.0, alpha: 1.0)
        keywordButton.translatesAutoresizingMaskIntoConstraints = false
        
        keywordButton.addTarget(self, action: #selector(keywordButtonDidTapped(_:)), for: .touchUpInside)
        
        return keywordButton
    }()
    
    // MARK: Methods
    
    @objc private func backButtonDidTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteButtonDidTapped(_ sender: UIButton) {
        if let deleteMemoViewController = self.storyboard?.instantiateViewController(withIdentifier: "DeleteMemoViewController") as? DeleteMemoViewController {
            deleteMemoViewController.data = data
            deleteMemoViewController.removeIdx = removeIdx
            
            deleteMemoViewController.modalPresentationStyle = .overCurrentContext
            self.present(deleteMemoViewController, animated: false, completion: nil)
        }
    }
    
    @objc private func keywordButtonDidTapped(_ sender: UIButton) {
        
        requestKeywords(data)
    }
    
    func requestKeywords(_ item: MemoData) {
        
        var pk: Int32 = 0
        
        if let key = item.pk {
            pk = key
        }
        
        let url = "http://13.125.76.112/api/board/analyze/\(pk)/pretty"
        let get = Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
        
        get.responseJSON { res in
            guard let jsonObject = res.result.value as? NSDictionary else {
                print("잘못된 응답")
                return
            }
            let keywords = jsonObject["result"] as! String
            
            var keyword: String = ""
            var strArray = [String]()
            
            for c in keywords {
                if c == "," || c == " " {
                    strArray.append(keyword)
                    keyword.removeAll()
                    
                } else {
                    keyword.append(c)
                }
            }
            
            item.keywords = strArray
            self.dao.update(data: item)
        }
        
        if let keywordNavigation = UIStoryboard(name: "Keyword", bundle: nil).instantiateInitialViewController() as? KeywordNavigation {
            
            if let keywordVC = keywordNavigation.topViewController as? KeywordVC {
                if let itemKeywords = item.keywords { 
                    keywordVC.data = data
                    self.present(keywordNavigation, animated: true, completion: nil)
                } else {
                    if let keywordErrorViewController = self.storyboard?.instantiateViewController(withIdentifier: "KeywordErrorMemoViewController") as? KeywordErrorViewController {
                        
                        keywordErrorViewController.modalPresentationStyle = .overCurrentContext
                        self.present(keywordErrorViewController, animated: false, completion: nil)
                    }
                }
            }
        }
    }

//    @objc private func repeatReloadView() {
//        print("reload")
//        self.view.setNeedsDisplay()
//    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if collectionView.isDescendant(of: self.view) {
            collectionView.removeFromSuperview()
        }
        // 데이터 처리
        // 코어 데이터에 저장된 데이터를 가져온다.
        appDelegate.memolist = dao.fetch()
        
        // data 초기화
        if data.title == nil {
            if let data = appDelegate.memolist.first {
                self.data = data
            }
        }
        
        self.navigationItem.titleView = titleLabel
        
        self.view.addSubview(titleLabel)
        self.view.addConstraints(titleLabelConstraints())
        self.view.addSubview(backButton)
        self.view.addConstraints(backButtonConstraints())
        self.view.addSubview(deleteButton)
        self.view.addConstraints(deleteButtonConstraints())

        if let _ = data.result {
            self.view.addSubview(editButton)
            self.view.addConstraints(editButtonConstraints())
            self.view.addSubview(resultBaseView)
            self.view.addConstraints(resultBaseViewConstraints())
            self.view.addSubview(resultTextView)
            self.view.addConstraints(resultTextViewConstraints())
            self.view.addSubview(collectionView)
            self.view.addConstraints(keywordsCollectionViewConstraints())
            self.view.addSubview(divisionView)
            self.view.addConstraints(divisionViewConstraints())
        }
        
        self.view.addSubview(contentTextView)
        if resultBaseView.isDescendant(of: self.view) {
            self.view.addConstraints(contentTextViewYesResultConstraints())
        } else {
            self.view.addConstraints(contentTextViewNoResultConstraints())
        }

        if !resultBaseView.isDescendant(of: self.view) {
            self.view.addSubview(keywordButton)
            self.view.addConstraints(keywordButtonConstraints())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 데이터 처리
        // 코어 데이터에 저장된 데이터를 가져온다.
        appDelegate.memolist = dao.fetch()
        
        
//        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(repeatReloadView), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        timer.invalidate()
    }
}

extension DetailViewController {
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 32.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 85.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 20.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func backButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: backButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 11.0/187.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: backButton, attribute: .centerY, relatedBy: .equal,
            toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 13.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backButton, attribute: .height, relatedBy: .equal,
            toItem: titleLabel, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func editButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: editButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 302.0/187.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: editButton, attribute: .centerY, relatedBy: .equal,
            toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: editButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 24.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: editButton, attribute: .height, relatedBy: .equal,
            toItem: titleLabel, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func deleteButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: deleteButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 332.0/187.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: deleteButton, attribute: .centerY, relatedBy: .equal,
            toItem: titleLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: deleteButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 24.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: deleteButton, attribute: .height, relatedBy: .equal,
            toItem: titleLabel, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func resultBaseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 104.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 321.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: resultBaseView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 111.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func resultTextViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .centerY, relatedBy: .equal,
            toItem: resultBaseView, attribute: .centerY, multiplier: 1.0, constant: 10.0)
        let centerXConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .centerX, relatedBy: .equal,
            toItem: resultBaseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .width, relatedBy: .equal,
            toItem: resultBaseView, attribute: .width, multiplier: 0.9, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: resultTextView, attribute: .height, relatedBy: .equal,
            toItem: resultBaseView, attribute: .height, multiplier: 0.9, constant: 0.0)
        
        return [centerYConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func keywordsCollectionViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: collectionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 238.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: collectionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: collectionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 299.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: collectionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 30.0/667.0, constant: 0.0)

        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 312.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 301.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 2.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func contentTextViewNoResultConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 89.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 303.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 350.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func contentTextViewYesResultConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 339.0/333.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 303.0/375.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: contentTextView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 350.0/667.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func keywordButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -54.0)
        let leadingConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: keywordButton, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}

extension DetailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.keywords?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        cell.backgroundColor = UIColor.init(hex: 0xffcd00)
        cell.title.textColor = .white
        cell.title.text = data.keywords?[indexPath.item]
        return cell
    }
}

extension DetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard collectionViewLayout is UICollectionViewFlowLayout else {
            return .zero
        }
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
        
        return cellCount > 0 ? UIEdgeInsetsMake(0, 0, 0, 0) : .zero
    }
}

