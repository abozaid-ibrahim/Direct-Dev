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
    var logs:[VisaStatusLog] = []
    var id:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appVeryLightGray
        tableView.defaultSeperator()
        setupTableData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withTitle(id ?? ""))
    }

    private func setupTableData() {
        tableView.registerNib(OrderDetailsTableCell.cellId)
        Observable<[VisaStatusLog]>.just(logs)
            .bind(to: tableView.rx.items(cellIdentifier: OrderDetailsTableCell.cellId,cellType: OrderDetailsTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
    }

    @IBAction func homeAction(_: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
