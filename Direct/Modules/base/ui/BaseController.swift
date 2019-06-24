//
//  BaseController.swift
//  Direct
//
//  Created by abuzeid on 6/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol BaseViewController {
    var disposeBag: DisposeBag { get }
    var showProgress: BehaviorRelay<Bool> { get }
}

extension BaseViewController {
    func subscribeToProgress() {
        showProgress.subscribe(onNext: { value in

            if value {
                Progress.show()
            } else {
                Progress.hide()
            }

        }).disposed(by: disposeBag)
    }
}
