//
//  InstitutesListController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import PanModal
import RxSwift
import UIKit
final class InstitutesListController: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "المعاهد"
        setupTableDataSource()
        setupTableOnSelect()
    }

    private func setupTableDataSource() {
        tableView.registerNib(InstituteTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: InstituteTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! InstituteTableCell)
                //                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }

    private func setupTableOnSelect() {
        tableView.rx.itemSelected.asObservable().subscribe { [unowned self] event in
            switch event.event {
            case .next(let indexPath):
                try! AppNavigator().push(.instituteDetails)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
