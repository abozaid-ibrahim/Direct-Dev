//
//  OrderDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
final class OrderDetailsController: UIViewController, StyledActionBar {
    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle("2344"))
        setupTableData()
    }

    private func setupTableData() {
        tableView.registerNib(OrderTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! OrderTableCell)
            }.disposed(by: disposeBag)
    }

    @IBAction func homeAction(_: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
