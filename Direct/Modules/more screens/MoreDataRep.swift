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
    case aboutUs, branches, banks, callUs, share

    var title: String {
        switch self {
        case .aboutUs:
            return "About Us".localized
        case .banks:
            return "Banks"
        case .branches:
            return "Branches"
        case .callUs:
            return "Call Us"
        case .share:
            return "Share"
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
     
        }
    }

    var viewController: UIViewController {
        switch self {
        case .aboutUs:
            return AboutUsViewController()
        case .callUs:
            return ContactUsViewController()
        case .banks:
            return BanksViewController()
        case .share:
            return getTextSharer(txt: "soe values to share.......") 
        case .branches:
            return BranchesController()
      
        }
    }

    private func getTextSharer(txt: String) -> UIViewController {
        let text = "This is some text that I want to share."
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.view.tintColor = .appPumpkinOrange
        activityViewController.view.tintColor = .appVeryLightGray
        return activityViewController
    }

    var presentationType: UIModalPresentationStyle {
        switch self {
        case  .share:
            return UIModalPresentationStyle.popover
        default:
            return UIModalPresentationStyle.fullScreen
        }
    }
}
