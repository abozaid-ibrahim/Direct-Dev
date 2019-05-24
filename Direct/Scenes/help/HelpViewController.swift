//
import PanModal
import RxSwift
//  HelpViewController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import UIKit
final class HelpViewController: UIViewController, PanModalPresentable, StyledActionBar {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle("مساعدة"))
        tableView.registerNib(HelpTableCell.cellId)
        view.backgroundColor = UIColor.appOffWhite
        tableView.backgroundColor = .appOffWhite

        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: HelpTableCell.cellId)) { _, _, _ in
//                let mycell = (cell as! HelpTableCell)
            }.disposed(by: disposeBag)
    }
}
