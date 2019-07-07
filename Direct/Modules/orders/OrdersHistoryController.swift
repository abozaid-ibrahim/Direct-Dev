//
//  OrdersHistoryController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class OrdersHistoryController: UIViewController, HaveLoading, StyledActionBar {
    private lazy var viewModel = OrdersHistoryViewModel(trackNo: self.trackNo ?? "")
    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    var trackNo: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appVeryLightGray
        tableView.registerNib(OrderTableCell.cellId)
        subscribeToProgress(viewModel.showProgress)
        bindDataToTable()
        setupActionBar(.withTitle("طلباتي"))
        setONItemSelected()
    }

    private func setONItemSelected() {
        tableView.rx.modelSelected(CompletedVisa.self)
            .subscribe(onNext: { [unowned self] value in
                print(value)
                try! AppNavigator().push(.orderDetails)
            }).disposed(by: disposeBag)
    }

    @IBAction func followStateAction(_: Any) {}

    private func bindDataToTable() {
        viewModel.completedVisa
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId, cellType: OrderTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}

