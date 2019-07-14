//
//  AboutUsViewModel.swift
//  Direct
//
//  Created by abuzeid on 7/9/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

class AboutUsViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()

    var aboutText: Observable<AboutPage?> {
      return  Observable<AboutPage?>.create { observer in
            self.showProgress.onNext(true)
            self.network.getAboutUs().subscribe(onNext: { [unowned self] value in
                observer.onNext(value.aboutPage?.first)
                self.showProgress.onNext(false)
            }).disposed(by: self.disposeBag)
        return Disposables.create()
        }
    }
}
