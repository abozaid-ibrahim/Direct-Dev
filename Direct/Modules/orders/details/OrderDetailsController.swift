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
        view.backgroundColor = .appVeryLightGray
        tableView.defaultSeperator()
        setupActionBar(.withTitle("2344"))
        setupTableData()
    }

    private func setupTableData() {
        tableView.registerNib(OrderDetailsTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: OrderDetailsTableCell.cellId,cellType: OrderDetailsTableCell.self)) { _, _, cell in
//                cell.setCellData(<#T##model: OrderDetailsTableCell.CellDataModel##OrderDetailsTableCell.CellDataModel#>)
            }.disposed(by: disposeBag)
    }

    @IBAction func homeAction(_: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
