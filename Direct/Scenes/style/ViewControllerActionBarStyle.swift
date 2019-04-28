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
        navigationController?.navigationBar.barTintColor = UIColor.appPumpkinOrange
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.titleTextAttributes = [.font:UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.white]
        switch style {
        case .withTitle(let title):
            self.navigationController?.navigationBar.topItem?.title = title

        case .withTitleAndX(let title):
            self.title =  title
        case .withTitleAndBack(let title):
            self.title =  title
        default:
            print("TODO")
        }
    }

}
