//
//  Navigator.swift
//  Direct
//
//  Created by abuzeid on 4/25/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit

/* if any contoller need any dependencies, it should passed in the destination item */

enum Destination {
    case loginView, signupView, homeScreen, visaRequirement(VisaRequestParams),
        selectableSheet(data: [String], titleText: String?,
                        style: CellStyle),
        paymentMethod(VisaRequestParams), passangersCount, newInstitueVisa, datePicker(title: String?), hostsInfoScreen, passangersInfoScreen(VisaRequestParams), successVisaReqScreen(USVvisaRequestJSONResponse?), MyOrders, orderDetails, institutesList, instituteDetails, packageDetails, successPackage, banks, newDirectVisa, searchCountries, confirmatonVisa(VisaRequestParams)
    func controller() -> UIViewController {
        switch self {
        case .loginView:
            return AuthViewController(.login)
        case .signupView:
            return AuthViewController(.register)
        case .homeScreen:
            let home = HomeViewController.instance("HomeViewController")
            return home
        case let .visaRequirement(data):
            let controller = VisaRequirementController()
            controller.visaData = data
            return controller
        case let .selectableSheet(data, title, style):
            let vc = SelectableTableSheet()
            vc.data = data
            vc.style = style
            vc.titleText = title
            return vc
        case let .paymentMethod(cost):
            let vc = PaymentViewController()
            vc.totalCost = cost.totalCost ?? ""
            return vc
        case .passangersCount:
            return PassangersCountController()
        case .newInstitueVisa:
            return NewInstituteRequestController()
        case .datePicker(let title):
            let date = DatePickerController()
            date.pickerTitle = title
            return date
        case .hostsInfoScreen:
            return SponsersViewController()
        case let .passangersInfoScreen(info):
            let vc = PassangersInputViewViewController()
            vc.visaInfo = info
            return vc
        case let .successVisaReqScreen(prm):
            let vc = SuccessVisaRequestController()
//            vc.orderId = prm.applyGB?.first?.success
            return vc
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
        case let .confirmatonVisa(cost):
            let vc = UIStoryboard.visa.instantiateViewController(withIdentifier: "VisaReqConfirmationController") as! VisaReqConfirmationController
            vc.visaRequestData = cost
            return vc
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
