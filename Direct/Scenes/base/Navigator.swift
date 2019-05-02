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
    case loginView, signupView,homeScreen,visaRequirement,selectableSheet(data:Any),paymentMethod
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
        case .paymentMethod:
            return PaymentViewController()
        }
    }
}

protocol Navigator {
    func present(_ dest:Destination)
    func push(_ dest:Destination)
    func startNewRoot(root:UINavigationController, _ dest:Destination)
    func presentModally(_ dest:Destination)
    
}
// once app navigator is intialized, it have a root controller to do all navigation on till it recieve new root,
final class AppNavigator:Navigator{
    
    func present(_ dest: Destination) {
        AppNavigator.rootController.present(dest.controller(), animated: true, completion: nil)
    }
    
    func presentModally(_ dest: Destination) {
        AppNavigator.rootController.presentPanModal(dest.controller() as! UIViewController & PanModalPresentable)
        
    }
    
    func push(_ dest: Destination) {
        AppNavigator.rootController.pushViewController(dest.controller(), animated: true)
        
    }
    
    func startNewRoot(root: UINavigationController, _ dest: Destination) {
        AppNavigator.rootController  = root
        
    }
    
    private static var rootController:UINavigationController!
    init(root:UINavigationController) {
        AppNavigator.rootController  = root
    }
    init() throws {
        if  AppNavigator.rootController == nil {
            throw NavigatorError.noRoot
        }
    }
    
}


enum NavigatorError:Error{
    case noRoot
}
