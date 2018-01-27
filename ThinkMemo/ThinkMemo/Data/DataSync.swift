//
//  DataSync.swift
//  UnithonMemo
//
//  Created by 최영준 on 2018. 1. 27..
//  Copyright © 2018년 최영준. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class DataSync {
    // 코어 데이터의 컨텍스트 객체
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // 앱 델리게이트 객체의 참조 정보를 읽어온다
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 서버에 백업된 데이터 내려받기
    func downloadBackupData() {
        // 최초 한 번만 다운로드 받도록 체크
        let ud = UserDefaults.standard
        guard ud.value(forKey: "firstLogin") == nil else {
            return
        }
        
        // 서버 호출
    
        // 영구 저장소에 커밋한다.
        do {
            try context.save()
        } catch let e as NSError {
            context.rollback()
            NSLog("error: %s", e.localizedDescription)
        }
        // 다운로드가 끝났으므로 이후로는 실행되지 않도록 처리
        ud.setValue(true, forKey: "firstLogin")
    }
    
    // Memo 엔터티에 저장된 모든 데이터 중에서 동기화되지 않은 것을 찾아 업로드한다.
    func uploadData() {
        // 요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        // 최신 글 순으로 정렬
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        // 업로드가 되지 않은 데이터만 추출
        fetchRequest.predicate = NSPredicate(format: "sync == false")
        
        do {
            let resultSet = try context.fetch(fetchRequest)
            
            // 읽어온 결과 집합을 순회하면서 [MemoData] 타입으로 변환한다.
            for record in resultSet {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                print("upload data == \(record.title!)")
                
                // 서버에 업로드한다.
                uploadDatum(record) {
                    if record === resultSet.last { // 마지막 데이터의 업로드가 끝났다면 로딩 표시 해제
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
        } catch let error as NSError {
            print("error: error.localizedDescription")
        }
    }
    
    // 인자값으로 입력된 개별 MemoMo 객체를 서버에 업로드한다.
    func uploadDatum(_ item: MemoMO, complete: (() -> Void)? = nil) {
        // 헤더 설정
        
        // 전송할 값 설정
        let param: Parameters = [
            "user": appDelegate.userId,
            "title": item.title!,
            "content": item.content!,
            //"create_date": self.dateToString(item.regdate!)
        ]
        
        // 전송
        let url = "http://52.79.215.229/api/board/"
        let upload = Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        // 응답 및 결과 처리
        upload.responseJSON { res in
            guard let jsonObject = res.result.value as? NSDictionary else {
                print("잘못된 응답입니다.")
                return
            }
            
            guard let pk = jsonObject["pk"] as? Int32 else {
                print("잘못된 응답입니다.")
                return
            }
            
            item.pk = pk
            
            // 코어 데이터에 반영
            do {
                item.sync = true
                try self.context.save()
            } catch let e as NSError {
                self.context.rollback()
                NSLog("error: %s", e.localizedDescription)
            }
        }
    }
}

// MARK: DataSync 유틸 메소드
extension DataSync {
    // String -> Date
    func stringToDate(_ value: String) -> Date {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    
    // Date -> String
    func dateToString(_ value: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
}
