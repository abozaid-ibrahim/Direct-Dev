//
//  BanksViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation

import RxDataSources
import RxSwift

class BanksViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()
    var banksList = PublishSubject<[ChildPaymentMethod]>()
    func getBanksList() {
        network.getChildPayment(method: PaymentMethodsIDs.bankTransfer.rawValue.string).subscribe(onNext: { [unowned self] value in
            self.banksList.onNext(value.paymentMethods)
        }).disposed(by: disposeBag)
    }
}
