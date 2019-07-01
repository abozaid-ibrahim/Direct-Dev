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

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet var branchsTable: UITableView!
    @IBOutlet var paymentMethodTable: UITableView!
    @IBOutlet var chooseBranchLbl: UILabel!
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

    var paymentType: PaymentMethodsIDs? {
        return PaymentMethodsIDs(rawValue: prm.parent_payment_id ?? 0)
    }

    private func setupCheckoutFooter() {
        checkoutFooter.action = { [weak self] in
            guard let self = self,
                let type = self.paymentType else { return }
            if type == PaymentMethodsIDs.creditCard {
                self.showPaymentController()
            } else {
                self.validateAndSubmit()
            }
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
        self.prm.userid = 703
        if prm.parent_payment_id == nil {
            return
        }
        guard let id = PaymentMethodsIDs(rawValue: prm.parent_payment_id ?? 0) else { return }
        if prm.child_payment_id == nil, PaymentMethodsIDs.creditCard != id {
            return
        }

        Progress.show()
        network.updatePaymentDetails(prm).subscribe(onNext: { _ in
            Progress.hide()
            try! AppNavigator().push(.successVisaReqScreen(nil))
        }).disposed(by: disposeBag)
    }

    private func registerCells() {
        paymentMethodTable.registerNib(PaymentMethodTableCell.cellId)
        branchsTable.registerNib(PaymentBranchTableCell.cellId)
        paymentMethodTable.dropShadow()
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
        paymentMethodTable.rx.modelSelected(PaymentMethod.self)
//            .startWith(first)
            .subscribe(onNext: { value in
                self.prm.parent_payment_id = value.id.int
                self.prm.child_payment_id = nil
                self.setBranchsDataSource(value)
            }).disposed(by: disposeBag)
//        let firstIndex = IndexPath(item: 0, section: 0)
////        (self.paymentMethodTable.cellForRow(at: firstIndex) as! PaymentMethodTableCell).setSelected(true, animated: true)
////        self.pay
//        paymentMethodTable.rx.itemDeselected
//            .subscribe(onNext: { [unowned self] value in
//                (self.paymentMethodTable.cellForRow(at: value) as! PaymentMethodTableCell).setSelected(false, animated: true)
//
//            }).disposed(by: disposeBag)
//        paymentMethodTable.rx.itemSelected
//            .startWith(firstIndex)
//            .subscribe(onNext: { [unowned self] value in
//                (self.paymentMethodTable.cellForRow(at: value) as! PaymentMethodTableCell).setSelected(true, animated: true)
//            }).disposed(by: disposeBag)
    }

    private func getImageFor(id: Int) -> String {
        guard let idMap = PaymentMethodsIDs(rawValue: id) else {
            return ""
        }
        return idMap.icons
    }

    private func setBranchsDataSource(_ method: PaymentMethod) {
        submitEnabled.accept(false)
        if (method.id.int ?? 0) == PaymentMethodsIDs.creditCard.rawValue {
            setBranches([])
            submitEnabled.accept(true)
            detailsView.alpha = 0
            return
        }
        detailsView.alpha = 1
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

    private func showPaymentController() {
        guard let payFortController = PayFortController(enviroment: KPayFortEnviromentSandBox) else { return }
        let deviceID = UIDevice.current.identifierForVendor!.uuidString

        let crd = PayFortCredintials.development(udid: deviceID)
        network.getSdkToken(crd).subscribe(onNext: { [unowned self] results in

            if let token = results.sdkToken {
                guard let cost = self.totalCost?.double(),
                    let id = self.requestId else { return }
                self.ShowPayfort(controller: payFortController, with: CurrentOrder(orderTotalSar: cost, id: id), token: token)

            } else {
                self.showAlert(with: "Failed to initialize your payment gateway")
            }

        }).disposed(by: disposeBag)
    }

    private func ShowPayfort(controller: PayFortController, with order: CurrentOrder, token: String) {
        //        let user = UserManager.shared.currentUserInfo
        let request = NSMutableDictionary()
        let updatedAmount: Float = Float(order.orderTotalSar * 100)

        request.setValue(updatedAmount, forKey: "amount")
        request.setValue("PURCHASE", forKey: "command") // PURCHASE - AUTHORIZATION
        request.setValue("SAR", forKey: "currency")
        request.setValue("saeed@direct-trvl.com", forKey: "customer_email")
        request.setValue("ar", forKey: "language")
        request.setValue(order.id, forKey: "merchant_reference")
        request.setValue(token, forKey: "sdk_token")
        controller.callPayFort(withRequest: request,
                               currentViewController: self,
                               success: { _, operationResult in
                                   guard let result = operationResult,
                                       let msg = result["response_message"] as? String,
                                       let code = result["response_code"] as? String,
                                       let fortId = result["fort_id"] as? String else {
                                       self.showAlert(with: Str.technicalDifficults)
                                       return
                                   }

                                   let status = result["status"]
                                   self.prm.online_payment_respose_msg = String(msg)
                                   self.prm.online_payment_respose_code = code
                                   self.prm.online_payment_respose_status = "\(status!)"
                                   self.prm.online_payment_respose_fortid = fortId
                                   self.validateAndSubmit()

                               }, canceled: { _, _ in
                                   self.showAlert(with: "Payment has been canceled")
                                   print("Canceled")
                               }, faild: { _, _, error in
                                   self.showAlert(with: error ?? "")
                                   print("Failed")
        })
    }

    func showAlert(with msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)

        let cancel = UIAlertAction(title: Str.cancel, style: .cancel, handler: nil)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}

enum PaymentStatus: Int {
    case success = 2,
        pending = 1,
        failed = 0
}
