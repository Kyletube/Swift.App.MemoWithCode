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
    case basic = "기본"
    case important = "중요"
    case urgent = "긴급"
}
