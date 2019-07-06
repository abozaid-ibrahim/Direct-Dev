//
//  OrdersHistoryController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
final class OrdersHistoryController: UIViewController, StyledActionBar {
    private lazy var viewModel = OrdersHistoryViewModel(trackNo: self.trackNo ?? "")
    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    var trackNo: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        setupActionBar(.withTitle("طلباتي"))
        viewModel.completedVisa.subscribe(onNext: { [unowned self] value in
            print(value)

        }).disposed(by: disposeBag)
    }

    @IBAction func followStateAction(_: Any) {
        try! AppNavigator().push(.orderDetails)
    }

    private func setupTableData() {
        tableView.registerNib(OrderTableCell.cellId)
        viewModel.completedVisa
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId, cellType: OrderTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}
