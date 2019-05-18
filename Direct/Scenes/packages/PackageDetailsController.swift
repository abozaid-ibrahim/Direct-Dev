//
//  PackageDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
class PackageDetailsController: UIViewController,StyledActionBar {
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withX)
    }

    @IBAction func bookNowAction(_: Any) {
        try? AppNavigator().push(.successPackage)
    }
}
