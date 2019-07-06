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
        view.backgroundColor = UIColor.appVeryLightGray
        setupTableData()
        setupActionBar(.withTitle("طلباتي"))
        viewModel.getCompletedVisa()
    }

    @IBAction func followStateAction(_: Any) {
        try! AppNavigator().push(.orderDetails)
    }

    private func setupTableData() {
        tableView.registerNib(OrderTableCell.cellId)
        viewModel.completedVisa.debug()
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId, cellType: OrderTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}
