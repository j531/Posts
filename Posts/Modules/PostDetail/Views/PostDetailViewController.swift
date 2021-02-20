//
//  PostDetailViewController.swift
//
//  Created by Joshua Simmons on 20/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PostDetailTableViewController: UITableViewController {

    // MARK: Public properties

    var viewModel: PostDetailViewModel?

    // MARK: Private properties

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindToViewModel()
    }

    // MARK: Setup

    private func setupView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostDetailTitleTableViewCell.self, forCellReuseIdentifier: PostDetailTitleTableViewCell.className)
        tableView.register(PostDetailLabelTableViewCell.self, forCellReuseIdentifier: PostDetailLabelTableViewCell.className)
        tableView.register(PostDetailCommentTableViewCell.self, forCellReuseIdentifier: PostDetailCommentTableViewCell.className)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets.vertical(20)
    }

    // MARK: Binding

    private func bindToViewModel() {
        let input = PostDetailViewModel.Input()

        guard let output = viewModel?.transform(input) else { return }

        tableView.dataSource = nil
        output.rowItems.asDriver(onErrorDriveWith: Driver.never())
            .drive(tableView.rx.items) ({ [weak self] tableView, index, item -> UITableViewCell in
                guard let strongSelf = self else { return UITableViewCell() }
                return strongSelf.dequeueCell(tableView: tableView, index: index, rowItem: item)
            })
            .disposed(by: disposeBag)
    }

    // MARK: Helpers

    private func dequeueCell(tableView: UITableView, index: Int, rowItem: Any) -> UITableViewCell {
        let indexPath = IndexPath(row: index, section: 0)

        switch rowItem {

        case let item as PostDetailTitleRowItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailTitleTableViewCell.className, for: indexPath)
            (cell as? PostDetailTitleTableViewCell)?.setup(with: item)
            return cell

        case let item as PostDetailBodyRowItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailLabelTableViewCell.className, for: indexPath)
            (cell as? PostDetailLabelTableViewCell)?.bodyLabel.text = item.body
            return cell

        case let item as PostDetailCommentsInfoItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailLabelTableViewCell.className, for: indexPath)
            let labelCell = cell as? PostDetailLabelTableViewCell
            labelCell?.bodyLabel.text = item.title
            labelCell?.bodyLabel.font = Fonts.avenirNext.ofSize(18, weight: .medium)
            labelCell?.bodyLabel.textColor = UIColor.black
            return cell

        case let item as PostDetailCommentItem:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostDetailCommentTableViewCell.className, for: indexPath)
            (cell as? PostDetailCommentTableViewCell)?.setup(with: item)
            return cell

        default: return UITableViewCell()

        }
    }
}
