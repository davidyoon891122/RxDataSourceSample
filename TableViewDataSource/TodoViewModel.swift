//
//  TodoViewModel.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation
import RxSwift

protocol TodoViewModelInput {
    func loadTodoList()
}

protocol TodoViewModelOutput {

}

protocol TodoViewModelType {
    var inputs: TodoViewModelInput { get }
    var outputs: TodoViewModelOutput { get }
}


final class TodoViewModel: TodoViewModelInput, TodoViewModelOutput, TodoViewModelType {
    var inputs: TodoViewModelInput { self }
    var outputs: TodoViewModelOutput { self }

    private var todoList: [TodoModel] = [
        TodoModel(
            todoId: UUID().uuidString,
            userName: "david",
            title: "random",
            contents: "random contents"
        )
    ]


    func loadTodoList() {

    }
}
