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

//    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()
    var dataSubject: Observable<CompletedOrdersJsonResponse> {
        return self.network.getCompletedOrders(trackNo: self.trackNo)
    }
}
