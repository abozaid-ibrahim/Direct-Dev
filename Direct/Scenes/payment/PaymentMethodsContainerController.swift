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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        let tab1 = ("حوالة بنكية", {
             print("selected")
        })
        let tab2 = ("حوالة بنكية", {
            print("selected")
        })
       
    let tabbar = TabBar(tabs: [tab1,tab2])
    tabsContainer.addSubview(tabbar)
        
        tabbar.sameBoundsTo(parentView: tabsContainer)
    }
    
    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    
    private func setupTableData() {
        tableView.registerNib(SingleRowTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! SingleRowTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}
