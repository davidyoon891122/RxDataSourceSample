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
    var todoListPublishSubject: PublishSubject<[TodoModel]> { get }
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInput { get }
    var outputs: TodoViewModelOutput { get }
}


final class TodoViewModel: TodoViewModelInput, TodoViewModelOutput, TodoViewModelType {
    var inputs: TodoViewModelInput { self }
    var outputs: TodoViewModelOutput { self }

    var todoListPublishSubject: PublishSubject<[TodoModel]> = .init()

    private var todoList: [TodoModel] = [
        TodoModel(
            todoId: UUID().uuidString,
            userName: "david",
            title: "random",
            contents: "random contents"
        ),
        TodoModel(
            todoId: UUID().uuidString,
            userName: "david",
            title: "Create a Repository",
            contents: "Create a Repository Contents"
        ),
        TodoModel(
            todoId: UUID().uuidString,
            userName: "david",
            title: "Vue.js Test",
            contents: "Create a Vue.js sample test"
        ),
    ]


    func loadTodoList() {
        outputs.todoListPublishSubject.onNext(todoList)
    }
}
