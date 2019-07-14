//
//  ContactUsViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/14/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

class ContactUsViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()

    var textValues: Observable<Values?> {
        return Observable<Values?>.create { observer in
            self.showProgress.onNext(true)
            self.network.getContactUs().subscribe(onNext: { [unowned self] value in
                observer.onNext(value.values)
                self.showProgress.onNext(false)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }

    func submit(values: ContactUsFormParams) {
        self.showProgress.onNext(true)
        self.network.getContactUs().subscribe(onNext: { [unowned self] value in

            print(value)
            self.showProgress.onNext(false)
        }).disposed(by: self.disposeBag)
    }
    func submit(name:String,email:String,phone:String,subject:String){
        let prm = ContactUsFormParams(key: User.authKey, lang: AppLanguage.langCode, name: name, email: email, mobile: phone, subjectID: 0, trackNo: "0", message: subject)
        showProgress.onNext(true)
        network.submitContactUs(prm: prm).subscribe(onNext: {[unowned self] value in
            self.showProgress.onNext(false)
        }).disposed(by: disposeBag)
    }
}
