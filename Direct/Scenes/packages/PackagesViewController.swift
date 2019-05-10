//
//  PackagesViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

class PackagesViewController: UIViewController,SwipeUpDismissable {
    private let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame:CGRect?{
        didSet{
            self.view.frame = defaultFrame ?? CGRect.zero
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableSwipeUpToDismiss()
    }
    
}
