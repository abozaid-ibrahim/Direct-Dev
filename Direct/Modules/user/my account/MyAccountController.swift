//
//  MyAccountController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
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
}



final class MyAccountController: UIViewController {

    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nibWithCellClass: AboutUsTableCell.self)
        
    }

    @IBAction func login(_: Any) {
        try! AppNavigator().present(.loginView)
    }
}


extension MyAccountController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreDataRep.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AboutUsTableCell.self)
        
        cell.cellTitleLabel.text = MoreDataRep.allCases[indexPath.row].title.localized
        cell.iconImage.image = MoreDataRep.allCases[indexPath.row].image
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    
    
    
}
