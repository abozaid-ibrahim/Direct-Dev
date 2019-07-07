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

    var datalist: [CompletedVisa] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.defaultSeperator()
        view.backgroundColor = UIColor.appVeryLightGray
        tableView.registerNib(OrderTableCell.cellId)
        subscribeToProgress(viewModel.showProgress)
//        bindDataToTable()
        setupActionBar(.withTitle("طلباتي"))
        setDatasource()
    }

    @IBAction func followStateAction(_: Any) {}
}

extension OrdersHistoryController {
    func setDatasource() {
        tableView.defaultSeperator()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.registerNib(OrderTableCell.cellId)
        tableView.registerNib(PendingDocTableCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.completedVisa.subscribe(onNext: { [unowned self] value in
            self.datalist = value // .map{VisaOrderDataSection}
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension OrdersHistoryController: UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return datalist.count
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pending = datalist[section].pendingDocs else {
            return 1
        }
        return pending.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { //this is always the header
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableCell.cellId) as? OrderTableCell else {
                return UITableViewCell()
            }
            cell.setCellData(datalist[indexPath.section])

            return cell
        } else {
            //this is for expanded cells
            let cell = tableView.dequeueReusableCell(withIdentifier: PendingDocTableCell.cellId) as! PendingDocTableCell
            let model = datalist[indexPath.section].pendingDocs?[indexPath.row]
            cell.setCellData(model?.documentFor ?? model?.documentName ?? model?.variableName ?? "")
            return cell
        }
    }
}

extension OrdersHistoryController: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        try! AppNavigator().push(.orderDetails)
    }
}
