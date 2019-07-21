//
//  LanguagesViewController.swift
//  Direct
//
//  Created by abuzeid on 7/15/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Localize_Swift
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
            .just(AppLanguage.languages)
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId, cellType: SingleRowTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
        tableView.rx.modelSelected(LangEntity.self).map { $0.name }.bind(to: selectedLang).disposed(by: disposeBag)
        tableView.rx.modelSelected(LangEntity.self).subscribe(onNext: { [unowned self] value in
            self.setCurrentLang(lang: value)

        }).disposed(by: disposeBag)
    }

    private func setCurrentLang(lang: LangEntity) {
        if Localize.currentLanguage() ==  lang.code{
            return
        }
        Localize.setCurrentLanguage(lang.code)
    }

    private func addfooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 72))
        let button = UIButton()
        button.applyStyle(.primary)
        footer.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        button.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController()
            }).disposed(by: disposeBag)

        footer.backgroundColor = .appVeryLightGray
        tableView.tableFooterView = footer
    }
}


