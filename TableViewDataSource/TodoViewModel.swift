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
    func modifyCompleteState(selectedTodo: Todo)
}

protocol TodoViewModelOutput {
    var todoListPublishSubject: PublishSubject<[TodoModel]> { get }
    var todoListDatasourcePublishSubject: PublishSubject<[TodoSectionModel]> { get }
}

protocol TodoViewModelType {
    var inputs: TodoViewModelInput { get }
    var outputs: TodoViewModelOutput { get }
}


final class TodoViewModel: TodoViewModelInput, TodoViewModelOutput, TodoViewModelType {
    var inputs: TodoViewModelInput { self }
    var outputs: TodoViewModelOutput { self }

    var todoListPublishSubject: PublishSubject<[TodoModel]> = .init()
    var todoListDatasourcePublishSubject: PublishSubject<[TodoSectionModel]> = .init()

    var disposeBag = DisposeBag()

    var todoList: [Todo] = []

    private var todoListDataSource: [TodoSectionModel] = [
        TodoSectionModel(header: "Header", items: [
                Todo(userId: 0, id: 0, title: "test", completed: false)
            ])

    ]

    func loadTodoList() {
        NetworkManager.shared.requestJsonHolder(
            url: URLInfo.todo.url,
            type: [Todo].self
        )
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.todoList = $0
                let todoListSectionModel = [TodoSectionModel(
                    header: "Header",
                    items: $0
                )]
                self.outputs.todoListDatasourcePublishSubject.onNext(todoListSectionModel)
            })
            .disposed(by: disposeBag)
        
    }

    func modifyCompleteState(selectedTodo: Todo) {
        guard var todo = todoList.filter({ todo in
            todo.id == selectedTodo.id
        }).first else { return }
        todo.completed = !todo.completed

        todoList = todoList.filter {
            $0.id != todo.id
        }
        print("length: \(todoList.count)")
        todoList.append(todo)
        print("length: \(todoList.count)")
        let todoListSectionModel = [TodoSectionModel(
            header: "Header",
            items: todoList
        )]
        outputs.todoListDatasourcePublishSubject.onNext(todoListSectionModel)
    }
}
