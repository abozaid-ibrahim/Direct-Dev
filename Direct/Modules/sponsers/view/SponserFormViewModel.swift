//
//  SponserFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/23/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift

class SponserFormViewModel {
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

    var nameSubject = PublishSubject<String?>()
    var pageSubject = PublishSubject<String?>()
    var imageSubject = PublishSubject<String?>()

    let network = ApiClientFacade()
    private let disposeBag = DisposeBag()
    func configureBinding(){
    }
    func submitData() {
        network.uploadSponserInfo(params: params).subscribe(onNext: { [unowned self] value in
            print(value)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}
