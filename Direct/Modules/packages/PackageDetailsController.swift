//
//  PackageDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class PackageDetailsController: UIViewController, StyledActionBar {
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withX)
    }
    @IBAction func bookNowAction(_: Any) {
        try? AppNavigator().push(.successPackage)
    }
}
