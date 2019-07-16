//
//  BanksViewController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

final class BanksViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet private var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private let viewModel = BanksViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "البنوك"
        viewModel.getBanksList()
        tableView.backgroundColor = .appVeryLightGray
        view.backgroundColor = .appVeryLightGray
        tableView.registerNib(BankTableCell.cellId)
        tableView.defaultSeperator()
        viewModel.banksList.bind(to: tableView.rx.items(cellIdentifier: BankTableCell.cellId, cellType: BankTableCell.self)) { _, model, cell in
            cell.setCellData(model)
        }.disposed(by: disposeBag)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
