//
//  Memo.swift
//  MemoWOC
//
//  Created by Kyle on 2023/08/24.
//

import Foundation

struct Memo {
    var id: Int
    var content: String
    var isCompleted: Bool
    var category: String
}

enum MemoCategory: String, CaseIterable {
    case basic = "기 본"
    case important = "중 요"
    case urgent = "긴 급"
}
