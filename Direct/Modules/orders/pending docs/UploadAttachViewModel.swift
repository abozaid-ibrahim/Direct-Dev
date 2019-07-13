//
//  UploadAttachViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

class UploadAttachViewModel: BaseViewModel {
    init() {
        getBanksList()
    }
    
    private let disposeBag = DisposeBag()
    private let network = ApiClientFacade()
    private var banksListBuffer: [ChildPaymentMethod] = []
    // UI Outputs
    var completedVisa = PublishSubject<[CompletedVisa]>()
    var showProgress = PublishSubject<Bool>()
    // UI Inputs
    var nameValue = BehaviorSubject<String?>(value: nil)
    var amountValue = BehaviorSubject<String?>(value: nil)
    var selectedDate = BehaviorSubject<Date?>(value: nil)
    var selectedBank = BehaviorSubject<ChildPaymentMethod?>(value: nil)
    var operationCompleted = PublishSubject<Bool>()

    var validInputs:Observable<Bool>{
     return Observable.combineLatest(nameValue, amountValue, selectedDate, selectedBank).map {return $0 != nil && $1 != nil && $2 != nil && $3 != nil }
    }
    private func getBanksList() {
        network.getChildPayment(method: PaymentMethodsIDs.bankTransfer.rawValue.string).subscribe(onNext: { [unowned self] value in
            self.banksListBuffer = value.paymentMethods
        }).disposed(by: disposeBag)
    }
    
    func showDatePickerDialog() {
        let dest = Destination.datePicker(title: Str.choose)
        let vc = dest.controller() as! DatePickerController
        vc.selectedDate.subscribe(onNext: { [unowned self] value in
            self.selectedDate.onNext(value)
        }).disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
    
    func showBanksListDialog() {
        let items = banksListBuffer.map { $0.paymentName }
        let dest = Destination.selectableSheet(data: items, titleText: Str.choose, style: .textCenter)
        let vc = dest.controller() as! SelectableTableSheet
        vc.selectedItem.subscribe(onNext: { [unowned self] value in
            let selected = self.banksListBuffer.filter { $0.paymentName == value }.first
            self.selectedBank.onNext(selected)
        }).disposed(by: disposeBag)
        try! AppNavigator().presentModally(vc)
    }
    
    func submit(prm: CompletedVisa, name: String, amount: String, date: String, bank: String) {
        let prm = UpdatePendingDocsParams(key: User.authKey, lang: AppLanguage.langCode, visaReqID: prm.visaReqID.intValue, userid: User.id, transDate: date, transBank: bank.int ?? 0, transAccName: name, transAmount: amount.int
            ?? 0)
        showProgress.onNext(true)
        network.updatePendingDocs(prm: prm).subscribe(onNext: { [unowned self] _ in
            self.showProgress.onNext(false)
            self.operationCompleted.onNext(true)
        }).disposed(by: disposeBag)
    }
}
