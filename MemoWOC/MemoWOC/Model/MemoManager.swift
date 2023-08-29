//
//  MemoManager.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import Foundation

struct MemoManager {
    static func saveMemoList(_ memoList: [Memo]) {
        var memoDictList: [[String: Any]] = []
        
        for memo in memoList {
            let memoDict: [String: Any] = [
                "id": memo.id,
                "content": memo.content,
                "isCompleted": memo.isCompleted,
                "category": memo.category
            ]
            memoDictList.append(memoDict)
        }
        
        UserDefaults.standard.set(memoDictList, forKey: "MemoListKey")
    }
    
    static func loadMemoList() -> [Memo] {
        var memoList: [Memo] = []
        
        if let savedMemoList = UserDefaults.standard.array(forKey: "MemoListKey") as? [[String: Any]] {
            for memoDict in savedMemoList {
                var content = ""
                if let contentValue = memoDict["content"] as? String {
                    content = contentValue
                }
                
                var isCompleted = false
                if let isCompletedValue = memoDict["isCompleted"] as? Bool {
                    isCompleted = isCompletedValue
                }
                
                var category = ""
                if let categoryValue = memoDict["category"] as? String {
                    category = categoryValue
                }
                
                if let idValue = memoDict["id"] as? Int {
                    let memo = Memo(id: idValue, content: content, isCompleted: isCompleted, category: category)
                    memoList.append(memo)
                }
            }
        }
        
        return memoList
    }
}
