//
//  MyAccountResources.swift
//  Direct
//
//  Created by abuzeid on 7/8/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import Foundation
import RxSwift
import Social
import UIKit

enum MoreDataRep: CaseIterable {
    case aboutUs, branches, banks, callUs, share, appLanguage, logout

    var title: String {
        switch self {
        case .aboutUs:
            return "about_us_label"
        case .banks:
            return "banks_label"
        case .branches:
            return "branches_label"
        case .callUs:
            return "call_us_label"
        case .share:
            return "share_label"
        case .appLanguage:
            return "app_lang_label"
        case .logout:
            return "logout_label"
        }
    }

    var image: UIImage {
        switch self {
        case .aboutUs:
            return #imageLiteral(resourceName: "icons8Information")
        case .branches:
            return #imageLiteral(resourceName: "icons8Museum")
        case .banks:
            return #imageLiteral(resourceName: "icons8MastercardCreditCard")
        case .callUs:
            return #imageLiteral(resourceName: "icons8Phone")
        case .share:
            return #imageLiteral(resourceName: "icons8Share")
        case .logout:
            return #imageLiteral(resourceName: "icons8Share")
        case .appLanguage:
            return #imageLiteral(resourceName: "icons8Geography")
        }
    }

    var viewController: UIViewController {
        switch self {
        case .aboutUs:
            return AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
        case .callUs:
            return ContactUsViewController()
        case .banks:
            return BanksViewController()
        case .share:
            return SLComposeServiceViewController()
        case .branches:
            return  BranchesController()
        default:
            return UIViewController()
        }
    }
}
