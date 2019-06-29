//
//  PaymentViewController.swift
//  Direct
//
//  Created by abuzeid on 4/30/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxCocoa
import RxSwift
import UIKit

final class PaymentViewController: UIViewController, PanModalPresentable {
    // MARK: IBuilder ====================================>>

    @IBOutlet var branchsTable: UITableView!
    @IBOutlet var paymentMethodTable: UITableView!
    @IBOutlet var checkoutFooter: CheckoutFooter!
    //===================================================<<
    private var submitEnabled = BehaviorRelay<Bool>(value: false)

    var panScrollable: UIScrollView? {
        return branchsTable
    }

    private var prm = SubmitPaymentParams()
    private let disposeBag = DisposeBag()
    private let network = ApiClientFacade()
    var totalCost: String?
    var requestId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Str.payment
        prm.reqid = requestId
        setupCheckoutFooter()
        getPaymentMethods()
        registerCells()
    }

    private func setupCheckoutFooter() {
        checkoutFooter.action = { [weak self] in
            guard let self = self else { return }
            self.validateAndSubmit()
        }
        submitEnabled
            .map { $0 ? UIColor.appPumpkinOrange : UIColor.disabledBtnBg }
            .bind(to: checkoutFooter.btn.rx.backgroundColor)
            .disposed(by: disposeBag)
        submitEnabled
            .bind(to: checkoutFooter.btn.rx.isEnabled)
            .disposed(by: disposeBag)
        checkoutFooter.valueText = totalCost?.priced
        checkoutFooter.bg = UIColor.appOffWhite
    }

    private func getPaymentMethods() {
        Progress.show()
        network.getAllPaymentMethods().subscribe(onNext: { value in
            self.setupPaymentMethodDataSource(value.paymentMethods ?? [])
            Progress.hide()

        }, onError: { _ in
            self.setupPaymentMethodDataSource([])
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func validateAndSubmit() {
        if prm.child_payment_id == nil || prm.parent_payment_id == nil {
            return
        }

        Progress.show()
        network.updatePaymentDetails(prm).subscribe(onNext: { _ in
            Progress.hide()

            if (self.prm.parent_payment_id ?? 0) == PaymentMethodsIDs.creditCard.rawValue {
                try! AppNavigator().push(.gotoPayByCreditCard)
            } else {
                try! AppNavigator().push(.successVisaReqScreen(nil))
            }
        }).disposed(by: disposeBag)
    }

    private func registerCells() {
        paymentMethodTable.registerNib(PaymentMethodTableCell.cellId)
        branchsTable.registerNib(PaymentBranchTableCell.cellId)
    }

    private func setupPaymentMethodDataSource(_ methods: [PaymentMethod]) {
        guard let first = methods.first else {
            return
        }
        methods.forEach { $0.imageName = getImageFor(id: $0.id.int ?? 0) }
        Observable<[PaymentMethod]>.just(methods)
            .bind(to: paymentMethodTable.rx.items(cellIdentifier: PaymentMethodTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! PaymentMethodTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)

        paymentMethodTable.rx.modelSelected(PaymentMethod.self).startWith(first).subscribe(onNext: { value in
            self.prm.parent_payment_id = value.id.int
            self.prm.child_payment_id = nil
           
            self.setPaymentMethodBranchsDataSource(value)

        }).disposed(by: disposeBag)
    }

    private func getImageFor(id: Int) -> String {
        guard let idMap = PaymentMethodsIDs(rawValue: id) else {
            return ""
        }
        return idMap.icons
    }

    private func setPaymentMethodBranchsDataSource(_ method: PaymentMethod) {
         self.submitEnabled.accept(false)
        if (method.id.int ?? 0) == PaymentMethodsIDs.creditCard.rawValue {
            setBranches([])
            submitEnabled.accept(true)
            return
        }
        Progress.show()
        network.getChildPayment(method: method.id).subscribe(onNext: { [unowned self] value in
            Progress.hide()
            self.setBranches(value.paymentMethods)
        }).disposed(by: disposeBag)

        branchsTable.rx
            .modelSelected(ChildPaymentMethod.self)
            .subscribe(onNext: { value in
                self.prm.child_payment_id = value.id.int
                self.submitEnabled.accept(true)
            })
            .disposed(by: disposeBag)
    }

    private func setBranches(_ br: [ChildPaymentMethod]) {
        Observable<[ChildPaymentMethod]>.just(br)
            .bind(to: branchsTable.rx.items(cellIdentifier: PaymentBranchTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! PaymentBranchTableCell)

                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}

extension UITableView {
    func registerNib(_ id: String) {
        register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
}

enum PaymentMethodsIDs: Int {
    case bankTransfer = 8, cach = 3, creditCard = 2
    var icons: String {
        switch self {
        case .bankTransfer:
            return "bankTransfer"
        case .cach:
            return "cashInHand"
        case .creditCard:
            return "icons8StackOfMoney"
        }
    }
}
