//
//  AuthViewController.swift
//  Daleel
//
//  Created by abdelrahman mohamed on 5/8/18.
//  Copyright © 2018 abdelrahman mohamed. All rights reserved.
//

import SnapKit
import SwifterSwift
import UIKit

class AuthViewController: UIViewController {
    lazy var logoImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "authlogo"))
        if #available(iOS 11.0, *) {
            view.adjustsImageSizeForAccessibilityContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        view.contentMode = .center
        return view
    }()

    lazy var skipButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "group8"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.addTarget(self, action: #selector(dismissAuth), for: .touchUpInside)
        return btn
    }()

    lazy var loginBtn: UIButton = {
        let login = UIButton()
        login.localizedText = "login_title_label"
        login.localizedFont = .regular(14)
        login.setTitleColor(#colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1), for: .normal)
        login.addTarget(self, action: #selector(changeForm(_:)), for: .touchUpInside)
        return login
    }()

    lazy var registerBtn: UIButton = {
        let login = UIButton()
        login.localizedText = "signup_title_label"
        login.localizedFont = .regular(14)
        login.setTitleColor(#colorLiteral(red: 0.1960526407, green: 0.1960932612, blue: 0.1960500479, alpha: 1), for: .normal)
        login.addTarget(self, action: #selector(changeForm(_:)), for: .touchUpInside)
        return login
    }()

    lazy var actionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginBtn, registerBtn])
        stack.axis = .horizontal
        stack.spacing = 40
        stack.distribution = .fillEqually
        return stack
    }()

    lazy var topView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [UIView(), logoImageView, actionStack])
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        return stack
    }()

    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9874494672, green: 0.5041492581, blue: 0.00973271206, alpha: 1)
        return view
    }()

    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        return view
    }()

    lazy var topContainerView: UIView = {
        let view = UIView()
        view.addSubviews([topView, indicatorView, separatorView])
        return view
    }()

    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var holderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topContainerView, containerView])
        stack.axis = .vertical
        return stack
    }()

    lazy var backgroundImage: UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "authbackground"))
        img.contentMode = .scaleAspectFill
        return img
    }()

    let authFrom: AuthTableViewController

    init(_ formType: AuthType) {
        authFrom = AuthTableViewController(formType)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews([backgroundImage, holderStack, skipButton])
        view.backgroundColor = .white
        add(authFrom, container: containerView)

        topContainerView.snp.makeConstraints { make in
            make.height.equalTo(view).multipliedBy(0.3)
        }

        topView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        switch authFrom.type {
        case .login:
            animateBtn(loginBtn)
        default:
            animateBtn(registerBtn)
        }

        separatorView.snp.makeConstraints { make in
            make.bottom.equalTo(topView)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(0.5)
        }

        holderStack.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(view)
            }
        }

        skipButton.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            } else {
                // Fallback on earlier versions
                make.leading.top.equalTo(view).inset(20)
            }
            make.width.height.equalTo(40)
        }

        backgroundImage.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
            make.height.equalToSuperview().multipliedBy(0.5)
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

    @objc func changeForm(_ sender: UIButton) {
        animateBtn(sender)
        switch sender {
        case loginBtn:
            authFrom.type = .login
        default:
            authFrom.type = .register
        }
    }

    func animateBtn(_ sender: UIButton) {
        indicatorView.snp.remakeConstraints { make in
            make.width.equalTo(sender)
            make.bottom.equalTo(sender)
            make.leading.equalTo(sender)
            make.height.equalTo(3)
        }

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: .curveEaseOut, animations: {
            self.topContainerView.layoutIfNeeded()
        }, completion: nil)

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            sender.transform = .identity
            sender.localizedFont = .bold(14)
        }

        switch sender {
        case loginBtn:
            registerBtn.localizedFont = .regular(14)
        default:
            loginBtn.localizedFont = .regular(14)
        }
    }
}
