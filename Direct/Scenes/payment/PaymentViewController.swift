//
//  PaymentViewController.swift
//  Direct
//
//  Created by abuzeid on 4/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

final class PaymentViewController: UIViewController, PanModalPresentable {
    @IBOutlet var checkoutFooter: CheckoutFooter!
    var panScrollable: UIScrollView? {
        return branchsTable
    }
    @IBOutlet var branchsTable: UITableView!
    @IBOutlet var paymentMethodTable: UITableView!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "الدفع"
    setupTables()
        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.hostsInfoScreen)
        }
    }
    func setupTables(){
        paymentMethodTable.registerNib(PaymentMethodTableCell.cellId)
        branchsTable.registerNib(PaymentBranchTableCell.cellId)
        Observable<[String]>.just(Array(dataList[0 ... 2]))
            .bind(to: paymentMethodTable.rx.items(cellIdentifier: PaymentMethodTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! PaymentMethodTableCell)
                //                mycell.setCellData((model,UIImage()))
            }.disposed(by: disposeBag)
        
        Observable<[String]>.just(dataList)
            .bind(to: branchsTable.rx.items(cellIdentifier: PaymentBranchTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! PaymentBranchTableCell)
                //                mycell.setCellData((model,UIImage()))
            }.disposed(by: disposeBag)
        
    }
}

extension UITableView {
    func registerNib(_ id: String) {
        register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}
