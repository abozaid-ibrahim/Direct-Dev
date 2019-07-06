//
//  OrdersHistoryViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

class OrdersHistoryViewModel {
    var trackNo: String
    init(trackNo: String) {
        self.trackNo = trackNo
    }

    private let disposeBag = DisposeBag()
//    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()

    var completedVisa = PublishSubject<[CompletedVisa]>() // {
//
//        return Observable<[CompletedVisa]>.create { observer in
//            self.network.getCompletedOrders(trackNo: self.trackNo).subscribe(onNext: { [unowned self] value in
//                observer.onNext(value.completedVisa ?? [])
//            }).disposed(by: self.disposeBag)
//            return Disposables.create()
//        }
//    }

    func getCompletedVisa() {
        self.network.getCompletedOrders(trackNo: self.trackNo).subscribe(onNext: { [unowned self] value in
            self.completedVisa.onNext(value.completedVisa ?? [])

        }).disposed(by: self.disposeBag)
    }
}
