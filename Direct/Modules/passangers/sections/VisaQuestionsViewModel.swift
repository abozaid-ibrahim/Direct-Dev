//
//  PassangerFormViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
class VisaQuestionsViewModel {
    private let network = ApiClientFacade()
    var selectedRelation = PublishSubject<String?>()

    var relativesList: [Relative] = []
    
    private let disposeBag = DisposeBag()
    func getRelatives() {
        let rel = network.getRelationList().retry(2)
        rel.subscribe(onNext: { [weak self] bios in
            self?.relativesList.append(contentsOf: bios.relatives ?? [])
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    

}
struct Segment {
    static let no = 0
}
