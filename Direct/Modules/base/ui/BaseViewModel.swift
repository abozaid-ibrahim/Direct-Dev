//
//  BaseViewModel.swift
//  Direct
//
//  Created by abuzeid on 6/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift

protocol BaseViewModel {
    var showProgress: PublishSubject<Bool> { get }
}
