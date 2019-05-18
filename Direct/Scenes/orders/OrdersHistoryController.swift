//
//  OrdersHistoryController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
final class OrdersHistoryController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        title = "طلباتي"
    }

    @IBAction func followStateAction(_: Any) {
        try! AppNavigator().push(.orderDetails)
    }

    private func setupTableData() {
        tableView.registerNib(OrderTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId)) { _, _, _ in
//                let mycell = (cell as! SingleRowTableCell)
                ///                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}
