//
//  Navigator.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import UIKit
import RxSwift

/* if any contoller need any dependencies, it should passed in the destination item */

enum Destination {
    
    case loginView, signupView, homeScreen, visaRequirement(country:String,totalCost:String?),
    selectableSheet(data: [String], titleText: String?
   ,style: CellStyle),
    paymentMethod(totalCost:String?), passangersCount, newInstitueVisa, datePicker, hostsInfoScreen, passangersInfoScreen, successVisaReqScreen, MyOrders, orderDetails, institutesList, instituteDetails, packageDetails, successPackage, banks,newDirectVisa,searchCountries, confirmatonVisa
    func controller() -> UIViewController {
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
            let home = HomeViewController.instance("HomeViewController")
            return home
        case .visaRequirement(let cid, let cost):
            let controller = VisaRequirementController()
            controller.country = cid
            controller.totalCost = cost
            return controller
        case  .selectableSheet(let data,let title,let style):
            let vc = SelectableTableSheet()
            vc.data = data
            vc.style = style
            vc.titleText = title
            return vc
        case .paymentMethod(let cost):
            let vc =  PaymentViewController()
            vc.totalCost = cost
            return vc
        case .passangersCount:
            return PassangersCountController()
        case .newInstitueVisa:
            return NewInstituteRequestController()
        case .datePicker:
            return DatePickerController()

        case .hostsInfoScreen:
            return SponsersViewController()
        case .passangersInfoScreen:
            return PassangersController()
        case .successVisaReqScreen:
            return SuccessVisaRequestController()
        case .MyOrders:
            return OrdersHistoryController()
        case .orderDetails:
            return OrderDetailsController()

        case .institutesList:
            return InstitutesListController()
        case .instituteDetails:
            return InstituteDetailsController()
        case .packageDetails:
            return PackageDetailsController()
        case .successPackage:
            return SuccessPackageController()
        case .banks:
            return BanksViewController()
        case .newDirectVisa:
            return NewDirectVisaController()
        case .searchCountries:
            return UIStoryboard.main.instantiateViewController(withIdentifier: "SearchViewController")
        case .confirmatonVisa:
            return UIStoryboard.visa.instantiateViewController(withIdentifier: "VisaReqConfirmationController")
        }
    }
}

protocol Navigator {
    func present(_ dest: Destination)
    func push(_ dest: Destination)
    func startNewRoot(root: UINavigationController, _ dest: Destination)
    func presentModally(_ dest: Destination)
}

// once app navigator is intialized, it have a root controller to do all navigation on till it recieve new root,
final class AppNavigator: Navigator {
    func present(_ dest: Destination) {
        AppNavigator.rootController.present(dest.controller(), animated: true, completion: nil)
    }

    func presentModally(_ dest: Destination) {
        AppNavigator.rootController.presentPanModal(dest.controller() as! UIViewController & PanModalPresentable)
    }
    func presentModally(_ vc: UIViewController) {
        AppNavigator.rootController.presentPanModal(vc as! UIViewController & PanModalPresentable)
    }

    func push(_ dest: Destination) {
        AppNavigator.rootController.pushViewController(dest.controller(), animated: true)
    }

    func startNewRoot(root: UINavigationController, _: Destination) {
        AppNavigator.rootController = root
    }

    private static var rootController: UINavigationController!
    init(root: UINavigationController) {
        AppNavigator.rootController = root
    }

    init() throws {
        if AppNavigator.rootController == nil {
            throw NavigatorError.noRoot
        }
    }
}

enum NavigatorError: Error {
    case noRoot
}
