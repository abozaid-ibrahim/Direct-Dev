//
//  SponserFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

class SponserFormViewModel:BaseViewModel {
    var showProgress =  PublishSubject<Bool>()
    
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
    var sponserOwnersSubject = PublishSubject<[SponsorOwener]>()
    var selectedSponsor = PublishSubject<SponsorOwener>()

    let network = ApiClientFacade()
    private let disposeBag = DisposeBag()
    func configureBinding() {}

    func submitData() {
        showProgress.onNext(true)
        network.uploadSponserInfo(params: params).subscribe(onNext: { [unowned self] value in
             self.showProgress.onNext(false)
            print(value)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    func getSponsorOwners() {
        network.getOwners(uid: 709, reqid: "30736", cid: "1").subscribe(onNext: { [unowned self] value in
            self.sponserOwnersSubject.onNext(value.sponsorOweners ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    func validateAndSubmit(sponserIndex:Int)->Bool{
        Observable.combineLatest(selectedSponsor,pageSubject,imageSubject, resultSelector: {sponser,sletter,statement in
            if (sponser.id ?? "").isEmpty  || sletter.isNilOrEmpty || statement.isNilOrEmpty {
                //is invalid
            }else{
                //
                self.params.sponserNo = sponserIndex
                self.submitData()
            }
            
        })
       return true
    }
}
protocol BaseViewModel {
    var showProgress: PublishSubject<Bool>{get}

}
