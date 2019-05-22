//
//  OrderDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//


import UIKit
import RxSwift
final class OrderDetailsController: UIViewController,StyledActionBar {
    
    @IBOutlet weak var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupActionBar(.withTitle("2344"))
        setupTableData()
        
    }
    private func setupTableData(){
        tableView.registerNib(OrderTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: OrderTableCell.cellId)) { row, model, cell  in
                let mycell = (cell as! OrderTableCell)
            }.disposed(by: disposeBag)
    }
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
