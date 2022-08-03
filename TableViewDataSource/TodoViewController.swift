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
        return view
    }()

    private lazy var todoTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

private extension TodoViewController {
    func setupViews() {

    }
}
