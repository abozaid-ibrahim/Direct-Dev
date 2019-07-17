//
//  SuccessRequestInstituteController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class SuccessRequestInstituteController: UIViewController, StyledActionBar {
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withX)
    }
}
