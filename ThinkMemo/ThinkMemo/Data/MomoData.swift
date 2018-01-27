//
//  MomoData.swift
//  UnithonMemo
//
//  Created by 최영준 on 2018. 1. 27..
//  Copyright © 2018년 최영준. All rights reserved.
//

import UIKit
import CoreData

class MemoData {
    var title: String?  // 메모 제목
    var content: String?   // 메모 내용
    var regdate: Date?      // 작성일
    var keywords: [String]? // 키워드
    var result: String? // 최종 내용
    var pk: Int32? // pk 번호
    
    // 원본 MemoMO 객체를 참조하기 위한 속성
    var objectID: NSManagedObjectID?
}
