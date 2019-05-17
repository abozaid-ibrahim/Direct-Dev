//
//  PaymentMethodsContainerController.swift
//  Direct
//
//  Created by abuzeid on 5/17/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
final class PaymentMethodsContainerController: UIViewController {
    @IBOutlet var tabsContainer: UIView!
    private let branchsData = Observable<[String]>.just(dataList)
    private let banksData = Observable<[String]>.just(["aaaa", "bbb"])
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(PaymentBranchTableCell.cellId)
        tableView.registerNib(BankTableCell.cellId)
        self.setupTableData()

        let tab1 = ("حوالة بنكية", {
            self.tableView.dataSource =  nil
             self.tableView.delegate =  nil
            self.setupTableData()
        })
        let tab2 = ("في أحد فروعنا", {
             self.tableView.dataSource =  nil
             self.tableView.delegate =  nil
            self.setupBranchTableData()
        })
        
        let tabbar = TabBar(tabs: [tab1, tab2])
        tabsContainer.addSubview(tabbar)
        
        tabbar.sameBoundsTo(parentView: tabsContainer)
    }
    
    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    private func setupTableData() {
        banksData.bind(to: tableView.rx.items(cellIdentifier: BankTableCell.cellId)) { _, _, cell in
            let mycell = (cell as! BankTableCell)
//                mycell.setCellData(model)
        }.disposed(by: disposeBag)
    }
    
    private func setupBranchTableData() {
        branchsData.bind(to: tableView.rx.items(cellIdentifier: PaymentBranchTableCell.cellId)) { _, _, cell in
            let mycell = (cell as! PaymentBranchTableCell)
            //                mycell.setCellData(model)
        }.disposed(by: disposeBag)
    }
}
