//
//  URLInfo.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation

enum URLInfo {
    case todo

    var url: URL? {
        switch self {
        case .todo:
            return URL(string: "http://localhost:5005/todolist")
        }
    }
}
