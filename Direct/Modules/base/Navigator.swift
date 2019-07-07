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
enum VisaRequirementType {
    case asAtab(country: String)
    case mainView(VisaRequestParams)
}
enum OrderDetails {
    case sourceA(trackNO:String)
    case mainView(VisaRequestParams)
}

enum Destination {
    case loginView,
        signupView,
        homeScreen,
        visaRequirement(VisaRequirementType),
        selectableSheet(data: [String], titleText: String?, style: CellStyle),
        paymentMethod(thanksUrl: String?, requestID: Int, totalCost: String),
        passangersCount,
        newInstitueVisa,
        datePicker(title: String?),
        sponsersInfoScreen(VisaRequestParams, reqID: String),
        passangersInfoScreen(VisaRequestParams),
        successVisaReqScreen(trackNo: String?, thanksUrl: String?),
        MyOrders(trackNo: String?),
    orderDetails(logs:[VisaStatusLog],id:String),
        institutesList,
        instituteDetails,
        packageDetails,
        successPackage,
        banks,
        newDirectVisa,
        searchCountries,
        confirmatonVisa(VisaRequestParams, reqID: String),
        gotoPayByCreditCard

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
            controller.inputs = data
            return controller
        case let .selectableSheet(data, title, style):
            let vc = SelectableTableSheet()
            vc.data = data
            vc.style = style
            vc.titleText = title
            return vc
        case let .paymentMethod(url, reqid, cost):
            let vc = PaymentViewController()
            vc.totalCost = cost
            vc.requestId = reqid
            vc.thanksUrl = url
            return vc
        case .passangersCount:
            return PassangersCountController()
        case .newInstitueVisa:
            return NewInstituteRequestController()
        case let .datePicker(title):
            let date = DatePickerController()
            date.pickerTitle = title
            return date
        case let .sponsersInfoScreen(visa, reqid):
            let vc = SponsersViewController()
            vc.reqID = reqid
            vc.visaInfo = visa
            return vc
        case let .passangersInfoScreen(info):
            let vc = PassangersInputViewViewController()
            vc.visaInfo = info
            return vc
        case let .successVisaReqScreen(prm):
            let vc = SuccessVisaRequestController()
            vc.trackNo = prm.trackNo
            vc.thanksUrl = prm.thanksUrl
            return vc
        case let .MyOrders(prm):
            let orders = UIStoryboard.main.controller(OrdersHistoryController.self) as! OrdersHistoryController
            orders.trackNo = prm
            return orders
        case let .orderDetails(logs):
            let vc = OrderDetailsController()
            vc.logs = logs.logs
            vc.id = logs.id
            return vc

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
        case let .confirmatonVisa(cost, reqID):
            let vc = UIStoryboard.visa.instantiateViewController(withIdentifier: "VisaReqConfirmationController") as! VisaReqConfirmationController
            vc.visaRequestData = cost
            vc.reqID = reqID
            return vc
        case .gotoPayByCreditCard:
            let vc = CreditCardController()
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

    func present(_ vc: UIViewController) {
        AppNavigator.rootController.present(vc, animated: true, completion: nil)
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

    func push(_ vc: UIViewController) {
        AppNavigator.rootController.pushViewController(vc, animated: true)
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
