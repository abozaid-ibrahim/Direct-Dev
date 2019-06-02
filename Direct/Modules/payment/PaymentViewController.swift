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
    let network = ApiClientFacade()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "الدفع"
        checkoutFooter.action = { [weak self] in
            try! AppNavigator().push(.hostsInfoScreen)
        }
        Progress.show()
        network.getAllPaymentMethods().subscribe(onNext: { value in
            self.setupPaymentMethodDataSource(value.paymentMethods ?? [])
            Progress.hide()
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func setupPaymentMethodDataSource(_ methods: [PaymentMethod]) {
        guard let first  = methods.first else {
            return
        }
        paymentMethodTable.registerNib(PaymentMethodTableCell.cellId)
        branchsTable.registerNib(PaymentBranchTableCell.cellId)
        Observable<[PaymentMethod]>.just(methods)
            .bind(to: paymentMethodTable.rx.items(cellIdentifier: PaymentMethodTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! PaymentMethodTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)
       
        paymentMethodTable.rx.modelSelected(PaymentMethod.self).startWith(first).subscribe(onNext: { value in
            self.selectChildBranchMethod(value)
            
        }).disposed(by: disposeBag)
        
//        paymentMethodTable.rx.itemSelected.subscribe(onNext: {[unowned self] value in
//            (self.paymentMethodTable.cellForRow(at: value) as! PaymentMethodTableCell).selectStyle(selected: true)
//            }, onError: nil, onCompleted: nil, onDisposed:  nil).disposed(by: disposeBag)
//
//
//        paymentMethodTable.rx.itemDeselected.subscribe(onNext: {[unowned self] value in
//            (self.paymentMethodTable.cellForRow(at: value) as! PaymentMethodTableCell).selectStyle(selected: false)
//            }, onError: nil, onCompleted: nil, onDisposed:  nil).disposed(by: disposeBag)

    }

    private func selectChildBranchMethod(_ method: PaymentMethod) {
        Progress.show()
        network.getChildPayment(method: method.id).subscribe(onNext: { [unowned self] value in
            Progress.hide()
            Observable<[ChildPaymentMethod]>.just(value.paymentMethods)
                .bind(to: self.branchsTable.rx.items(cellIdentifier: PaymentBranchTableCell.cellId)) { _, model, cell in
                    let mycell = (cell as! PaymentBranchTableCell)
                    mycell.setCellData(model)
                }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

extension UITableView {
    func registerNib(_ id: String) {
        register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}


