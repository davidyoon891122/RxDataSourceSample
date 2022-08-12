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
import RxDataSources

class TodoViewController: UIViewController {
    private lazy var remainTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .gray

        return label
    }()

    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            TodoTableViewCell.self,
            forCellReuseIdentifier: TodoTableViewCell.identifier
        )

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
            remainTaskLabel,
            todoTableView
        ]
            .forEach {
                view.addSubview($0)
            }

        remainTaskLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(16.0)
        }

        todoTableView.snp.makeConstraints {
            $0.top.equalTo(remainTaskLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    func bindUI() {
        typealias TodoSectionDataSource = RxTableViewSectionedReloadDataSource<TodoSectionModel>
        let dataSource: TodoSectionDataSource = {
            let ds = TodoSectionDataSource(configureCell: { (dataSource, tableView, indexPath, todo) -> UITableViewCell in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: TodoTableViewCell.identifier,
                    for: indexPath
                ) as? TodoTableViewCell else { return UITableViewCell() }
                cell.setupCell(todo: todo, viewModel: self.viewModel)
                cell.setButtonTag(index: indexPath.row)
                return cell
            })
            return ds
        }()


        viewModel.outputs.todoListDatasourcePublishSubject
            .debug("todoListDatasourcePublishSubject")
            .bind(to: todoTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.outputs.remainTaskPublushSubject
            .debug("remainTaskPublushSubject")
            .subscribe(onNext: { [weak self] remainTask in
                guard let self = self else { return }
                self.remainTaskLabel.text = "RemainTask: \(remainTask)"
            })
            .disposed(by: disposeBag)
    }
}
