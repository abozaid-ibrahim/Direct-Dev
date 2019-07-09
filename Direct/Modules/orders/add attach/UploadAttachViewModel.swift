//
//  UploadAttachViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//


import Foundation
import RxDataSources
import RxSwift

class UploadAttachViewModel: BaseViewModel {
    init() {

    }
    
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()
    
    var completedVisa = PublishSubject<[CompletedVisa]>()
    func submit(vname:String){
        
    }
}

