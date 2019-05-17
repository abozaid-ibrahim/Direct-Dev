//
//  OrdersHistoryController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
final class OrdersHistoryController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        title = "طلباتي"
    }
    @IBAction func followStateAction(_ sender: Any) {
        try! AppNavigator().push(.orderDetails)

    }
    private func setupTableData(){
        tableView.registerNib(OrderTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId)) { row, model, cell  in
//                let mycell = (cell as! SingleRowTableCell)
///                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}



