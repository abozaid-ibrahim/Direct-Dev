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
    var selectedLang = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle(Str.language))
        view.backgroundColor = .appVeryLightGray
        setupTableData()
    }

    private func setupTableData() {
        tableView.registerNib(SingleRowTableCell.cellId)
        Observable<[LangEntity]>
            .just([LangEntity(name: "Arabic", code: "ar", selected: true),
                   LangEntity(name: "English", code: "en", selected: false)])
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId, cellType: SingleRowTableCell.self)) { _, model, cell in
                cell.setCellData(model.name)
            }.disposed(by: disposeBag)
        tableView.rx.modelSelected(LangEntity.self).map{$0.name}.bind(to: selectedLang).disposed(by: disposeBag)
        
    }
}

struct LangEntity {
    var name: String
    var code: String
    var selected: Bool
}
