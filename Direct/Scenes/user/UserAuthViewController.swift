//
//  UserAuthViewController.swift
//  Direct
//
//  Created by abuzeid on 4/24/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

class UserAuthViewController: UIViewController {
    private lazy var signupController = SignupViewController()
    private lazy var loginController = LoginViewController()

    enum Views {
        case login, signup
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showView(_ view: Views) {
        switch view {
        case .login:
            if !hasChild(loginController.view) {
                setChild(loginController)
            }
            loginController.view.isHidden = false
            signupController.view.isHidden = true
        case .signup:
            if !hasChild(signupController.view) {
                setChild(signupController)
            }
            loginController.view.isHidden = true
            signupController.view.isHidden = false
        }
    }

    private func hasChild(_ childView: UIView) -> Bool {
        return view.subviews.contains(childView)
    }

    private func setChild(_ vc: UIViewController) {
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.frame = view.bounds
    }
}
