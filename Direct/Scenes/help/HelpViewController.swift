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
final class HelpViewController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(SingleRowTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! SingleRowTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}
