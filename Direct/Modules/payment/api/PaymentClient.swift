//
//  PaymentClient.swift
//  Direct
//
//  Created by abuzeid on 6/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// Payment
extension ApiClientFacade {
    func getAllPaymentMethods() -> Observable<PaymentMethodsResponse> {
        return Observable<PaymentMethodsResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.getAllParentPaymentMethod).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getChildPayment(method: String) -> Observable<PaymentChildsResponse> {
        return Observable<PaymentChildsResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.getChildsOfPayment(cid: method)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func updatePaymentDetails(_ prm: SubmitPaymentParams) -> Observable<UpdatePaymentResponse> {
        return Observable<UpdatePaymentResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.updatePaymentDetails(prm: prm)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    func getSdkToken(_ crd: PayFortCredintials) -> Observable<PayfortResponse> {
        return Observable<PayfortResponse>.create { (observer) -> Disposable in
            self.paymentProvider.rx.request(PaymentAPIs.initPayfort(crd)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
}
