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
import SwifterSwift
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
        setDatasource()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withTitle("طلباتي"))
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
        tableView.registerNib(ActionTableCell.cellId)
        tableView.dataSource = self
        viewModel.completedVisa.subscribe(onNext: { [unowned self] value in
            self.datalist = value
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension OrdersHistoryController: UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return datalist.count
    }

    func hasTransferBtn(section: Int) -> Bool {
        let method = datalist[section].paymentMethod?.int ?? -1
        let status = datalist[section].paymentStatus?.int ?? -1
        return (method == PaymentMethodsIDs.bankTransfer.rawValue) && (status == 0)
    }

    func getRowsCount(of section: Int) -> Int {
        let actionsCount = hasTransferBtn(section: section) ? 2 : 1
        guard let pending = datalist[section].pendingDocs else {
            return actionsCount
        }
        return pending.count + actionsCount
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getRowsCount(of: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionSize = getRowsCount(of: indexPath.section)
        let lastRow = (indexPath.row + 1) == sectionSize
        let BeforelastRow = hasTransferBtn(section: indexPath.section) && ((indexPath.row + 2) == sectionSize)

        if indexPath.row == 0 { //this is always the header
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableCell.cellId) as? OrderTableCell else {
                return UITableViewCell()
            }

            cell.setCellData(datalist[indexPath.section])
            cell.roundedTop(with: tableView.bounds.width)
            return cell
        } else if BeforelastRow {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionTableCell.cellId) as! ActionTableCell
            cell.setCellData((Str.reportBankTransfer, style: .secondary))
            cell.submitBtn.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                let obj = self.datalist[indexPath.section]
                let uploadVC = UploadPendingDocsController()
                uploadVC.request = obj
                try! AppNavigator().push(uploadVC)

            }).disposed(by: cell.disposeBag)

            return cell
        } else if lastRow {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActionTableCell.cellId) as! ActionTableCell
            cell.setCellData((Str.followOrder, style: .primary))
            cell.submitBtn.rx.tapGesture().when(.recognized).subscribe(onNext: { [unowned self] _ in
                let obj = self.datalist[indexPath.section]
                try! AppNavigator().push(Destination.orderDetails(logs: obj.visaStatusLog ?? [], id: obj.visaReqID ?? ""))

            }).disposed(by: cell.disposeBag)
            DispatchQueue.main.async {//adding delay until know wha'ts wrong with my table cell size
                cell.roundedBottom(with: tableView.bounds.width)
            }
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PendingDocTableCell.cellId) as! PendingDocTableCell
            print(sectionSize, indexPath)
            let model = datalist[indexPath.section].pendingDocs?[indexPath.row - 1]
            cell.setCellData(model?.documentFor ?? model?.documentName ?? model?.variableName ?? "")

            return cell
        }
    }
}
