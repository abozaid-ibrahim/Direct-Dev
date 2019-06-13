//
//  PassangerFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
class PassangerFormViewModel {
    private let network = ApiClientFacade()
    var selectedRelation = PublishSubject<String?>()

    var relativesList: [USRelative] = []
    
    private let disposeBag = DisposeBag()
    func getRelatives() {
        let rel = network.getUSLivingVisaRelatives().retry(2)
        rel.subscribe(onNext: { [weak self] bios in
            self?.relativesList.append(contentsOf: bios.usRelatives ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
  

}
