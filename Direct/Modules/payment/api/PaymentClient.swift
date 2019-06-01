//
//  PaymentClient.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import Moya

//Payment
extension ApiClientFacade{
    func getAllPaymentMethods() -> Observable<PaymentMethodsResponse> {
        return Observable<PaymentMethodsResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.getAllParentPaymentMethod).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    func getChildPayment(prm: VisaPriceParams) -> Observable<PaymentChildsResponse> {
        return Observable<PaymentChildsResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.getChildsOfPayment(cid: "")).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    func updatePaymentDetails(country:String) -> Observable<UpdatePaymentResponse> {
        return Observable<UpdatePaymentResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.updatePaymentDetails(prm: "")).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
