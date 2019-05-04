//
//  InstitutesListController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import PanModal
import RxSwift
import UIKit
final class InstitutesListController: UIViewController, PanModalPresentable {
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
