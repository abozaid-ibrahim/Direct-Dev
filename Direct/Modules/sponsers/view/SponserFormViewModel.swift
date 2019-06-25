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

    lazy var params: SponserFormParams = SponserFormParams(userid: nil,
                                                           visaReqID: nil,
                                                           sponserNo: nil,
                                                           ownerOfBankStmt: nil,
                                                           someoneElse: nil,
                                                           someoneElseAttachment: nil,
                                                           bankStmtAttachment: nil,
                                                           jobLetterAttachment: nil)
    var setAccountStatementLater = BehaviorSubject<Bool>(value:false)
    var setSalaryLetterLater = BehaviorSubject<Bool>(value:false)
    var lastAccountStatment = BehaviorSubject<String?>(value: nil)
    var sallaryLetterSubject = BehaviorSubject<String?>(value: nil)
    var formResult = PublishSubject<UploadSponserInfoResponse>()
    var sponserOwnersSubject = PublishSubject<[SponsorOwener]>()
    var selectedSponsor = PublishSubject<SponsorOwener>()

    let network = ApiClientFacade()
    private let disposeBag = DisposeBag()
    func configureBinding() {}

    func submitData() {
        showProgress.onNext(true)
        network.uploadSponserInfo(params: params)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.showProgress.onNext(false)
                self.formResult.onNext(value)
            }, onError: { _ in
                self.showProgress.onNext(false)
            }).disposed(by: disposeBag)
    }

    func getSponsorOwners() {
        network.getOwners(uid: 709, reqid: reqID, cid: cid)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.sponserOwnersSubject.onNext(value.sponsorOweners?.filter{$0.name.isValidText} ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func validateAndSubmit(name: String?) {
        if name.isNilOrEmpty {
            return
        }
        submitData()
    }
}
