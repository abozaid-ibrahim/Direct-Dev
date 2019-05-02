//
//  ViewControllerActionBarStyle.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
enum ActionBarStyles{
    case withTitle(String),withTitleAndX(String), withTitleAndBack(String), withX
}
protocol StyledActionBar {
    func setupActionBar(_ style:ActionBarStyles)
}
extension StyledActionBar where Self:UIViewController{
    func setupActionBar(_ style:ActionBarStyles){
        guard let navigationBar  = navigationController?.navigationBar else {
            addCustomNavigationBar(style)
            return
        }
        navigationBar.barTintColor = UIColor.appPumpkinOrange
//        navigationController?.navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.titleTextAttributes = [.font:UIFont.boldSystemFont(ofSize: 24),
                                             .foregroundColor: UIColor.white]
        switch style {
        case .withTitle(let title):
            navigationBar.topItem?.title = title
        case .withTitleAndX(let title):
            navigationBar.topItem?.title = title
//            let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "inst"), style: .plain, target: nil, action: nil)
//            self.navigationItem.rightBarButtonItem  = button1

        case .withTitleAndBack(let title):
            navigationBar.topItem?.title = title
        default:
            print("TODO")
        }
    }

    private func addCustomNavigationBar(_ style:ActionBarStyles){
        let navigationbarView = UIView(frame: CGRect(x: view.bounds.minX, y: view.bounds.minY, width: view.bounds.width, height: 50))
        navigationbarView.backgroundColor = UIColor.appPumpkinOrange
        let titleLbl = UILabel()
        navigationbarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navigationbarView)
        view.bringSubviewToFront(navigationbarView)
        func setCloseButton(){
            let close = UIButton()
            navigationbarView.addSubview(close)
            close.setTitle("Close;", for: .normal)
            close.rx.tap.bind {[weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
            close.translatesAutoresizingMaskIntoConstraints = false
            close.trailingAnchor.constraint(equalTo: navigationbarView.trailingAnchor, constant: 8).isActive = true
            close.centerYAnchor.constraint(equalTo: navigationbarView.centerYAnchor).isActive = true
        }
        func setTitle(_  title:String){
            titleLbl.text = title
            navigationbarView.addSubview(titleLbl)
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            titleLbl.centerYAnchor.constraint(equalTo: navigationbarView.centerYAnchor).isActive = true
            titleLbl.centerXAnchor.constraint(equalTo: navigationbarView.centerXAnchor).isActive = true
            
        }
        switch style {
        case .withTitle(let title):
           setTitle(title)
        case .withTitleAndX(let title):
            setCloseButton()
           setTitle(title)
        case .withTitleAndBack(let title):
            setTitle(title)
            setCloseButton()
        default:
            print("TODO")
        }
        
        
    }
    

}
