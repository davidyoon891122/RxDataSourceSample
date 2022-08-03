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
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

private extension TodoViewController {
    func setupViews() {
        [
            topView,
            todoTableView
        ]
            .forEach {
                view.addSubview($0)
            }

        let topViewHeight: CGFloat = 50.0
        topView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(topViewHeight)
        }

        todoTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
