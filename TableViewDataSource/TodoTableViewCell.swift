//
//  TodoTableViewCell.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation
import SnapKit
import UIKit

final class TodoTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private lazy var contentLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()

        return label
    }()

    func setupCell(title: String, content: String, userName: String) {

    }
}
