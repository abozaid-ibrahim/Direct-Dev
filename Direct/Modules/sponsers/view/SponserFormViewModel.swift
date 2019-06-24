//
//  SponserFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

class SponserFormViewModel: BaseViewModel {
    var showProgress = PublishSubject<Bool>()
    var index: Int
    var reqID: String
    var relationType: String
    var cid: String
    init(index: Int, type: String, visaReqID: String, cid: String) {
        self.index = index
        self.cid = cid
        self.relationType = type
        self.reqID = visaReqID
        params.visaReqID = visaReqID.int ?? 0
        params.sponserNo = index
    }

    lazy var params: SponserFormParams = SponserFormParams(key: nil,
                                                           lang: nil,
                                                           userid: nil,
                                                           visaReqID: nil,
                                                           sponserNo: nil,
                                                           ownerOfBankStmt: nil,
                                                           someoneElse: nil,
                                                           someoneElseAttachment: nil,
                                                           bankStmtAttachment: nil,
                                                           jobLetterAttachment: nil)

    var pageSubject = PublishSubject<String?>()
    var imageSubject = PublishSubject<String?>()
    var formResult = PublishSubject<UploadSponserInfoResponse>()
    var sponserOwnersSubject = PublishSubject<[SponsorOwener]>()
    var selectedSponsor = PublishSubject<SponsorOwener>()

    let network = ApiClientFacade()
    private let disposeBag = DisposeBag()
    func configureBinding() {}

    func submitData() {
        showProgress.onNext(true)
        network.uploadSponserInfo(params: params)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                print(Thread.current.name)
                self.showProgress.onNext(false)
                self.formResult.onNext(value)
            }, onError: { _ in
                self.showProgress.onNext(false)
            }).disposed(by: disposeBag)
    }

    func getSponsorOwners() {
        network.getOwners(uid: 709, reqid: reqID, cid: cid).subscribe(onNext: { [unowned self] value in
            self.sponserOwnersSubject.onNext(value.sponsorOweners ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func validateAndSubmit(name: String?)  {
        if name.isNilOrEmpty {
            return
        }
        submitData()
    }
}

protocol BaseViewModel {
    var showProgress: PublishSubject<Bool> { get }
}
