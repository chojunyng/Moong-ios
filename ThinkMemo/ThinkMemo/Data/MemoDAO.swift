//
//  MemoDAO.swift
//  UnithonMemo
//
//  Created by 최영준 on 2018. 1. 27..
//  Copyright © 2018년 최영준. All rights reserved.
//

import UIKit
import CoreData

class MemoDAO {
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    lazy var dao = MemoDAO()
    
    // 저장된 메모 전체를 불러오는 메서드
    func fetch() -> [MemoData] {
        var memoList = [MemoData]()
        
        // 요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        // 최신 글 순으로 정렬하도록 정렬 객체 생성
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultSet = try context.fetch(fetchRequest)
            // 읽어온 결과 집합을 순회하면서 [MemoData] 타입으로 변환한다.
            for record in resultSet {
                // MemoData 객체를 생성한다.
                let data = MemoData()
                
                // MemoMO 프로퍼티 값을 MemoData의 프로퍼티로 복사한다.
                data.title = record.title
                data.content = record.content
                data.regdate = record.regdate
                data.objectID = record.objectID
                data.pk = record.pk
                
                if let keywords = record.keywords as? [String] {
                    data.keywords = keywords
                }
                if let result = record.result {
                    data.result = result
                }
                
                // MemoData 객체를 memolist 배열에 추가한다.
                memoList.append(data)
            }
        } catch let error as NSError {
            NSLog("error: %s", error.localizedDescription)
        }
        return memoList
    }
    
    // 새 메모를 저장하는 메서드
    func insert(_ data: MemoData) {
        // 관리 객체 인스턴스 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: context) as! MemoMO
        
        // MemoData로부터 값을 복사한다.
        object.title = data.title
        object.content = data.content
        object.regdate = data.regdate
        
        if let keywords = data.keywords {
            object.keywords = keywords as NSArray
        }
        if let result = data.result {
            object.result = result
        }
        
        // 영구 저장소에 변경사항을 반영한다.
        do {
            try context.save()
            
            // 서버에 데이터를 업로드한다.
            let sync = DataSync()
            sync.uploadDatum(object)
            
        } catch let error as NSError {
            NSLog("error: %s", error.localizedDescription)
        }
    }
    
    // 메모 내용을 삭제하기 위한 메서드
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        // 삭제할 객체를 찾아 컨텍스트에서 삭제한다.
        let object = context.object(with: objectID)
        context.delete(object)
        print("델맅")
        // 서버에서 데이터를 제거한다.
        print((object as! MemoMO).pk)
        
        let sync = DataSync()
        sync.removeData(object as! MemoMO)
        
        do {
            // 삭제된 내용을 영구저장소에 반영한다.
            try context.save()
            return true
        } catch let error as NSError {
            NSLog("error: %s", error.localizedDescription)
            return false
        }
    }
    
    func update(data: MemoData) {
        let object = context.object(with: data.objectID!) as! MemoMO
        
        object.title = data.title
        object.content = data.content
        object.regdate = data.regdate
        
        if let pk = data.pk {
            object.pk = pk
        }
        if let keywords = data.keywords {
            object.keywords = keywords as NSArray
        }
        
        object.result = data.result
        
        // 영구 저장소에 변경사항을 반영한다.
        do {
            try context.save()
            
            // 서버에 데이터를 업로드한다.
            let sync = DataSync()
            sync.uploadDatum(object)
            
        } catch let error as NSError {
            NSLog("error: %s", error.localizedDescription)
        }
    }
}
