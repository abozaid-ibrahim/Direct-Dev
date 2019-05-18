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
    case withTitle(String), withTitleAndX(String), withTitleAndBack(String), withX
}

protocol StyledActionBar {
    var disposeBag: DisposeBag { get }
    func setupActionBar(_ style: ActionBarStyles)
}

extension StyledActionBar where Self: UIViewController {
    func setupActionBar(_ style: ActionBarStyles) {
        guard let navigationBar = navigationController?.navigationBar else {
            addCustomNavigationBar(style)
            return
        }
        navigationBar.isHidden = false
        // hide back button ttilel
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)

        navigationBar.barTintColor = UIColor.appPumpkinOrange
//        navigationController?.navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.setYellowGradient()
        navigationBar.titleTextAttributes = [.font: UIFont(name: AppFonts.boldFont, size: 24)!,
                                             .foregroundColor: UIColor.white]
        switch style {
        case let .withTitle(title):
            navigationBar.topItem?.title = title
        case let .withTitleAndX(title):
            navigationBar.topItem?.title = title
        case let .withTitleAndBack(title):
            navigationBar.topItem?.title = title
        case .withX:
            navigationBar.isHidden = true
            let xButton = UIImageView(image: #imageLiteral(resourceName: "group10"))
            xButton.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.navigationController?.popViewController(animated: true)
                    navigationBar.isHidden = false
                }).disposed(by: disposeBag)
            view.addSubview(xButton)
            xButton.translatesAutoresizingMaskIntoConstraints = false
            xButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
            xButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
            xButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            xButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            print("TODO")
        }
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
