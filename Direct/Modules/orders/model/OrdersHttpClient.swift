//
//  OrdersHttpClient.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// MARK: visa methods

extension ApiClientFacade {
    func getCompletedOrders(trackNo: String) -> Observable<CompletedOrdersJsonResponse> {
        return Observable<CompletedOrdersJsonResponse>.create { (observer) -> Disposable in
            
            self.ordersProvider.rx.request(OrdersAPIs.getCompletedVisa(trackNo: trackNo)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    func updatePendingDocs(prm: UpdatePendingDocsParams) -> Observable<HaveDonePaymentResponse> {
        return Observable<HaveDonePaymentResponse>.create { (observer) -> Disposable in
            
            self.ordersProvider.rx.request(OrdersAPIs.updateHaveDonePayment(prm)).subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
