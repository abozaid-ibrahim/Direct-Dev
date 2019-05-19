//
//  PassangersController.swift
//  Direct
//
//  Created by abuzeid on 5/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class PassangersController: UIViewController {
    @IBOutlet var tabbarContainer: TabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "معلومات المسافرين"

        setupTabbar()
    }

    private func setupTabbar() {
        let tab1 = ("بالغ 1", { [weak self] in

        })
        let tab2 = ("طفل 1", { [weak self] in

        })
        let tab3 = ("طفل 2", { [weak self] in

        })

        let tabbarView = TabBar(tabs: [tab1, tab2, tab3])
        tabbarContainer.addSubview(tabbarView)
        tabbarView.sameBoundsTo(parentView: tabbarContainer)
    }

    @IBAction func followAction(_: Any) {
        try! AppNavigator().push(.successVisaReqScreen)
    }
}
