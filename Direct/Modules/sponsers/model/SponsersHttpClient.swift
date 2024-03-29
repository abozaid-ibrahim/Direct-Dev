//
//  SponsersHttpClient.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

extension ApiClientFacade {
    func uploadSponserInfo(params: SponserFormParams) -> Observable<UploadSponserInfoResponse> {
        return Observable<UploadSponserInfoResponse>.create { (observer) -> Disposable in
            self.sponsersProvider.rx.request(SponsersAPIs.uploadSponserForm(prm: params))
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                Logger.log(Thread.current)
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func getOwners(uid: String, reqid: String, cid: String) -> Observable<EligableSponserResponse> {
        return Observable<EligableSponserResponse>.create { (observer) -> Disposable in
            self.sponsersProvider.rx
                .request(SponsersAPIs.getSponserOwner(userid: uid, reqid: reqid, cid: cid))
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .subscribe { [weak self] event in
                    self?.parser.emitDataModelfromResponse(event: event, observer: observer)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
