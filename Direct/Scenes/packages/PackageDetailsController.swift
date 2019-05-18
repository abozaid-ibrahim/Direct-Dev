//
//  PackageDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/10/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PackageDetailsController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func bookNowAction(_: Any) {
        try? AppNavigator().push(.successPackage)
    }
}
