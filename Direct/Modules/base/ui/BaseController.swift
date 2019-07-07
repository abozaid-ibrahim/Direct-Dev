//
//  BaseController.swift
//  Direct
//
//  Created by abuzeid on 6/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol HaveLoading {
    var disposeBag: DisposeBag { get }
    func subscribeToProgress(_ showProgress: Observable<Bool>)
}

extension HaveLoading {
    func subscribeToProgress(_ showProgress: Observable<Bool>) {
        showProgress.subscribe(onNext: { value in
            if value {
                Progress.show()
            } else {
                Progress.hide()
            }
        }).disposed(by: disposeBag)
    }
}
