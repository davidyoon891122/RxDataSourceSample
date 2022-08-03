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

    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var completeButton: UIButton = {
        let button = UIButton()

        return button
    }()



    func setupCell(
        title: String,
        content: String,
        userName: String
    ) {

    }
}

private extension TodoTableViewCell {
    func setupViews() {
        [
            titleLabel
        ]
    }
}
