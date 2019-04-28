//
//  Navigator.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

/*if any contoller need any dependencies, it should passed in the destination item*/
enum Destination{
    case loginView, signupView,homeScreen
}

protocol Navigator {
    func show(_ destination:Destination)
}

final class AppNavigator:Navigator{
    
    var rootController:RootNavigationViewController
    init(root:RootNavigationViewController) {
        self.rootController  = root
    }
    func show(_ destination: Destination) {
        let vc  = controller(of: destination)
        
        self.rootController.pushViewController(vc, animated: true)
    }
    func controller(of dest: Destination)->UIViewController{
        switch dest {
        case .loginView:
            let auth = UserAuthViewController()
            auth.showView(.login)
            return auth
        case .signupView:
            let auth = UserAuthViewController()
            auth.showView(.signup)
            return auth
        case .homeScreen:
            let home  = HomeViewController.instance("HomeViewController")
            return home
        }
    }
}


extension UIViewController{
    static func instance(_ mainStoryboardId:String)->UIViewController{
     return UIStoryboard.main.instantiateViewController(withIdentifier: mainStoryboardId)
    }
}
extension UIStoryboard{
    static var main:UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
