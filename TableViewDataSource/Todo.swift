//
//  Todo.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation
import RxDataSources

struct Todo {
    var userId: Int = 0
    var id: Int = 0
    var title: String = ""
    var completed: Bool = false
}

struct TodoSectionModel {
    var header: String
    var items: [Todo]

    init(header: String, items: [Todo]) {
        self.header = header
        self.items = items
    }
}

extension TodoSectionModel: SectionModelType {
    init(original: TodoSectionModel, items: [Todo]) {
        self = original
        self.items = items
    }
}
