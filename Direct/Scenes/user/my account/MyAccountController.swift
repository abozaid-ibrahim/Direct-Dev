//
//  MyAccountController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit
final class MyAccountController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(AboutUsTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: AboutUsTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! AboutUsTableCell)
//                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }

    @IBAction func login(_: Any) {
        try! AppNavigator().push(.loginView)
    }
}
