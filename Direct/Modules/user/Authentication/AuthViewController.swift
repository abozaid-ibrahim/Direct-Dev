//
//  AuthViewController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/8/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import UIKit
import SnapKit
import SwifterSwift

class AuthViewController: UIViewController {

    lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "group23"))
        view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var skipButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "group8"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.addTarget(self, action: #selector(dismissAuth), for: .touchUpInside)
        return btn
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    let authFrom: AuthTableViewController

    init(_ formType: AuthType) {
        authFrom = AuthTableViewController(formType)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews([logoImageView, containerView, skipButton])
        view.backgroundColor = .white
        add(authFrom, container: containerView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
            make.width.height.equalTo(140)
        }

        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)

        }

        skipButton.snp.makeConstraints { (make) in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(40)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func dismissAuth() {
        // remove token if user exited from phone activation
        switch authFrom.type {
        case .verifyPhoneNumber:
//            UserManager.deleteCurrentUser()
            break
        default:
            break
        }
        dismiss(animated: true, completion: nil)
    }

}
