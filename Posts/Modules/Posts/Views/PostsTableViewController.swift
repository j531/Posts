//
//  PostsTableViewController.swift
//
//  Created by Joshua Simmons on 19/03/2019.
//  Copyright © 2018 Joshua. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PostsTableViewController: UITableViewController {

    // MARK: Public properties

    var viewModel: PostsViewModel?

    // MARK: Private properties

    private let disposeBag = DisposeBag()

    private let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge).then {
        $0.color = Colors.darkGray
        $0.startAnimating()
    }

    private let emptyDataLabel = UILabel().then {
        $0.text = NSLocalizedString("No posts available", comment: "")
        $0.font = Fonts.avenirNext.ofSize(16)
        $0.textColor = Colors.darkGray
        $0.textAlignment = .center
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
        bindToViewModel()
    }

    // MARK: Setup

    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.className)
        tableView.backgroundView = loadingIndicator
        tableView.separatorInset = UIEdgeInsets.horizontal(14)
    }

    private func setupNavigationBar() {
        let title = NSLocalizedString("Posts", comment: "")
        self.title = title

        let titleLabel = UILabel()
        titleLabel.font = Fonts.avenirNext.ofSize(14, weight: .bold)
        titleLabel.textColor = Colors.darkBlue
        titleLabel.attributedText = NSAttributedString(string: title.uppercased(), attributes: [.kern: 3])
        navigationItem.titleView = titleLabel

        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = Colors.darkBlue
    }

    // MARK: Binding

    private func bindToViewModel() {
        let input = PostsViewModel.Input(didTapRow: tableView.rx.itemSelected.asObservable())

        guard let output = viewModel?.transform(input) else { return }

        tableView.dataSource = nil
        output.rowItems.asDriver(onErrorDriveWith: Driver.never())
            .drive(tableView.rx.items(
                cellIdentifier: PostTableViewCell.className, cellType: PostTableViewCell.self)) { _, item, cell in
                    cell.setup(with: item)
            }
            .disposed(by: disposeBag)

        output.isEmpty.asDriver(onErrorJustReturn: true)
            .drive(onNext: { [weak self] isEmpty in
                guard let strongSelf = self else { return }
                strongSelf.setBackgroundViewShown(strongSelf.emptyDataLabel, shown: isEmpty)
            })
            .disposed(by: disposeBag)

        output.isLoading.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] isLoading in
                guard let strongSelf = self else { return }
                strongSelf.setBackgroundViewShown(strongSelf.loadingIndicator, shown: isLoading)
            })
            .disposed(by: disposeBag)
    }

    // MARK: Helpers

    private func setBackgroundViewShown(_ view: UIView, shown: Bool) {
        if shown {
            tableView.backgroundView = view
        } else if tableView.backgroundView == view {
            tableView.backgroundView = nil
        }
    }
}
