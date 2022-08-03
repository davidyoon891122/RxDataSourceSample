//
//  TodoViewController.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/02.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class TodoViewController: UIViewController {
    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private var disposeBag = DisposeBag()

    private let viewModel = TodoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindUI()
        viewModel.inputs.loadTodoList()
    }
}

private extension TodoViewController {
    func setupViews() {
        [
            todoTableView
        ]
            .forEach {
                view.addSubview($0)
            }

        todoTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func bindUI() {
        viewModel.outputs.todoListPublishSubject
            .bind(to: todoTableView.rx.items) { tableView, indexPath, element in
                return UITableViewCell()
            }
            .disposed(by: disposeBag)
    }
}
