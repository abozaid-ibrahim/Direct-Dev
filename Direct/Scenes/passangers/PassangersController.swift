//
//  PassangersController.swift
//  Direct
//
//  Created by abuzeid on 5/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class PassangersController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func followAction(_ sender: Any) {
        try! AppNavigator().push(.successVisaReqScreen)

    }
}

extension SkyFloatingLabelTextField{
    func setAppStyle(){
        
    }
}
