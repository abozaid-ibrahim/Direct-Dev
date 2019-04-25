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
        self.navigationController?.navigationBar.backgroundColor = UIColor.yellow
        switch style {
        case .withTitle(let title):
             self.navigationController?.title =  title
        default:
            print("TODO")
        }
    }

}
