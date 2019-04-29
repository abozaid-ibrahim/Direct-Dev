//
//  Navigator.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import PanModal
/*if any contoller need any dependencies, it should passed in the destination item*/
enum Destination{
    case loginView, signupView,homeScreen,visaRequirement,selectableSheet(data:Any)
    func controller()->UIViewController{
        switch self {
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
        case .visaRequirement:
            let controller  = VisaRequirementController()
            return controller
        case .selectableSheet(let data):
            let vc = SelectableTableSheet()
            return vc
        }
    }
}

protocol Navigator {
    func show(_ destination:Destination)
    static func present(_ dest:Destination)
}

final class AppNavigator:Navigator{
    private static var rootController:RootNavigationViewController{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return  appDelegate.window!.rootViewController as! RootNavigationViewController
        
    }
    static func present(_ dest: Destination) {
        rootController.pushViewController(dest.controller(), animated: true)
    }
    static func presentModally(_ dest:Destination){
        
                   rootController.presentPanModal(dest.controller() as! UIViewController & PanModalPresentable)

    }
    
    var rootController:RootNavigationViewController
    init(root:RootNavigationViewController) {
        self.rootController  = root
    }
    func show(_ destination: Destination) {
        let vc  = destination.controller()
        self.rootController.pushViewController(vc, animated: true)
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
