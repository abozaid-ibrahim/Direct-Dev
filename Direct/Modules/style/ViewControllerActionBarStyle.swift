//
//  ViewControllerActionBarStyle.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
enum ActionBarStyles {
    case withTitle(String), withTitleAndX(String), withTitleAndBack(String), withX,
        hidden
}

protocol StyledActionBar {
    var disposeBag: DisposeBag { get }
    func setupActionBar(_ style: ActionBarStyles)
}

extension StyledActionBar where Self: UIViewController {
    func setupActionBar(_ style: ActionBarStyles) {
        guard let navigationBar = navigationController?.navigationBar else {
            self.addCustomNavigationBar(style)
            return
        }

        // hide back button ttilel
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)

        navigationBar.barTintColor = UIColor.appPumpkinOrange
//        navigationController?.navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.setYellowGradient()
        navigationBar.titleTextAttributes = [.font: UIFont(name: AppFonts.boldFont, size: 20)!,
                                             .foregroundColor: UIColor.white]
        switch style {
        case let .withTitle(title):
            navigationBar.isHidden = self.navigationController?.setNavigationBarHidden(false, animated: false)

            navigationBar.topItem?.title = title
            self.title = title
        case let .withTitleAndX(title):
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            navigationBar.topItem?.title = title
            self.title = title
        case let .withTitleAndBack(title):
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            navigationBar.topItem?.title = title
        case .withX:

            self.navigationController?.setNavigationBarHidden(true, animated: false)
            var backView = UIView()
            backView.backgroundColor = UIColor.black.withAlphaComponent(0.35)
            var back = UIImageView(image: #imageLiteral(resourceName: "group10"))
            backView.addSubview(back)

            backView.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.navigationController?.popViewController(animated: true)
                    navigationBar.isHidden = false
                }).disposed(by: disposeBag)
            view.addSubview(backView)
            self.setConstrains(back: &back, backView: &backView, view: &view)
        case .hidden:
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }

    private func setConstrains(back: inout UIImageView, backView: inout UIView, view: inout UIView) {
        back.translatesAutoresizingMaskIntoConstraints = false
        back.widthAnchor.constraint(equalToConstant: 30).isActive = true
        back.heightAnchor.constraint(equalToConstant: 30).isActive = true
        back.centerXAnchor.constraint(equalTo: backView.centerXAnchor).isActive = true
        back.centerYAnchor.constraint(equalTo: backView.centerYAnchor).isActive = true
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        backView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55).isActive = true
        backView.widthAnchor.constraint(equalToConstant: 45).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 45).isActive = true

        backView.cornerRadiusV = 22
        backView.clipsToBounds = true
    }

    private func addCustomNavigationBar(_ style: ActionBarStyles) {
        let navigationbarView = UIView(frame: CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 50))
        navigationbarView.backgroundColor = UIColor.appPumpkinOrange
        let titleLbl = UILabel()
        navigationbarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationbarView)
        view.bringSubviewToFront(navigationbarView)
        func setCloseButton() {
            let close = UIButton()
            navigationbarView.addSubview(close)
            close.setTitle("Close;", for: .normal)
            close.rx.tap.bind { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            close.translatesAutoresizingMaskIntoConstraints = false
            close.trailingAnchor.constraint(equalTo: navigationbarView.trailingAnchor, constant: 8).isActive = true
            close.centerYAnchor.constraint(equalTo: navigationbarView.centerYAnchor).isActive = true
        }
        func setTitle(_ title: String) {
            titleLbl.text = title
            navigationbarView.addSubview(titleLbl)
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            titleLbl.centerYAnchor.constraint(equalTo: navigationbarView.centerYAnchor).isActive = true
            titleLbl.centerXAnchor.constraint(equalTo: navigationbarView.centerXAnchor).isActive = true
        }
        switch style {
        case let .withTitle(title):
            setTitle(title)
        case let .withTitleAndX(title):
            setCloseButton()
            setTitle(title)
        case let .withTitleAndBack(title):
            setTitle(title)
            setCloseButton()
        default:
            print("TODO")
        }
    }
}
