//
//  LanguagesViewController.swift
//  Direct
//
//  Created by abuzeid on 7/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LanguagesViewController: UIViewController, StyledActionBar {
    @IBOutlet private var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle(Str.language))
        view.backgroundColor = .appVeryLightGray
        setupTableData()
    }

    private func setupTableData() {
        tableView.registerNib(SingleRowTableCell.cellId)
        Observable<[LangEntity]>.just([LangEntity(name: "Arabic", code: "ar", selected: true)])
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId, cellType: SingleRowTableCell.self)) { _, model, cell in
                cell.setCellData(model.name)
            }.disposed(by: disposeBag)
    }
}

struct LangEntity {
    var name: String
    var code: String
    var selected: Bool
}
