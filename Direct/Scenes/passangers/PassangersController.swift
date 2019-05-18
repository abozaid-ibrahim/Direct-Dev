//
//  PassangersController.swift
//  Direct
//
//  Created by abuzeid on 5/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import SkyFloatingLabelTextField
import UIKit

class PassangersController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "معلومات المسافرين"
    }

    @IBAction func followAction(_ sender: Any) {
        try! AppNavigator().push(.successVisaReqScreen)
    }
}
