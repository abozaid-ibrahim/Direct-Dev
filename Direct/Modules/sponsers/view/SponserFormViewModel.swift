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
        self.params.userid = index
    }

    lazy var params: SponserFormParams = SponserFormParams(userid: self.index,
                                                           visaReqID: nil,
                                                           sponserNo: nil,
                                                           ownerOfBankStmt: nil,
                                                           someoneElse: nil,
                                                           someoneElseAttachment: nil,
                                                           bankStmtAttachment: nil,
                                                           jobLetterAttachment: nil)
    var setAccountStatementLater = BehaviorSubject<Bool>(value: false)
    var setSalaryLetterLater = BehaviorSubject<Bool>(value: false)
    var lastAccountStatment = BehaviorSubject<String?>(value: nil)
    var sallaryLetterSubject = BehaviorSubject<String?>(value: nil)
    var formResult = PublishSubject<UploadSponserInfoResponse>()
    var sponserOwnersSubject = PublishSubject<[SponsorOwener]>()
    var selectedSponsor = PublishSubject<SponsorOwener>()

    private let network = ApiClientFacade()
    private let disposeBag = DisposeBag()

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

    private var someoneElse: SponsorOwener {
        return SponsorOwener(name: Str.someoneElse, id: "0", status: nil, success: nil)
    }
  
    func getSponsorOwners() {
        network.getOwners(uid: User.id, reqid: reqID, cid: cid)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                var list = value.sponsorOweners?.filter { $0.name.isValidText } ?? []
                list.append(self.someoneElse)
                self.sponserOwnersSubject.onNext(list)
            }).disposed(by: disposeBag)
    }

    func validateAndSubmit(name: String?) {
        if name.isNilOrEmpty {
            return
        }
        submitData()
    }
    
    var selectedRelation = PublishSubject<String?>()
    
    func getRelatives()  -> Observable<RelativesResponse> {
        return network.getRelationList().retry(1)
    }
    

}
