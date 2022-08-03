//
//  TodoModel.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation

struct TodoModel: Codable {
    var todoId: String = UUID().uuidString
    var userName: String = ""
    var title: String = ""
    var contents: String = ""
    var isCompleted: Bool = false
}
