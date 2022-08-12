//
//  TodoTableViewCell.swift
//  TableViewDataSource
//
//  Created by iMac on 2022/08/03.
//

import Foundation
import SnapKit
import UIKit
import RxCocoa
import RxSwift

final class TodoTableViewCell: UITableViewCell {
    static let identifier: String = "TodoTableViewCell"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(
            ofSize: 18.0,
            weight: .bold
        )
        label.numberOfLines = 0

        return label
    }()

    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "checkmark.circle")

        return imageView
    }()

    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "완료",
            for: .normal
        )
        button.setTitleColor(
            .gray,
            for: .normal
        )
        button.setTitleColor(
            .gray.withAlphaComponent(0.3),
            for: .highlighted
        )

        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 4.0

        return button
    }()

    private var disposeBag = DisposeBag()

    func setupCell(
        todo: Todo,
        viewModel: TodoViewModel
    ) {
        selectionStyle = .none
        titleLabel.text = todo.title
        setupViews()
        if todo.completed {
            checkImageView.image = UIImage(systemName: "checkmark.circle")
        } else {
            checkImageView.image = UIImage(systemName: "")
        }

        bindUI(todo: todo, viewModel: viewModel)
    }

    func setButtonTag(index: Int) {
        completeButton.tag = index
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

private extension TodoTableViewCell {
    func setupViews() {
        [
            titleLabel,
            checkImageView,
            completeButton
        ]
            .forEach {
                contentView.addSubview($0)
            }

        let imageSize: CGFloat = 30.0
        let offset: CGFloat = 16.0
        let buttonSize: CGFloat = 50.0
        checkImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(offset)
            $0.width.height.equalTo(imageSize)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(offset)
            $0.leading.equalTo(checkImageView.snp.trailing).offset(offset)
            $0.trailing.equalTo(completeButton.snp.leading).offset(-offset)
            $0.bottom.equalToSuperview().offset(-offset)
        }

        completeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-offset)
            $0.width.equalTo(buttonSize)

        }
    }

    func bindUI(
        todo: Todo,
        viewModel: TodoViewModel
    ) {
        completeButton.rx.tap
            .asDriver()
            .drive(onNext: {
                print("Tapped")
                viewModel.inputs.modifyCompleteState(selectedTodo: todo, tag: self.completeButton.tag)
            })
            .disposed(by: disposeBag)
    }
}
