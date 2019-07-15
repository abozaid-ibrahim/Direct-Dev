//
//  MyAccountController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import Social
import UIKit

final class MyAccountController: UIViewController, StyledActionBar {
    var disposeBag = DisposeBag()
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(nibWithCellClass: AboutUsTableCell.self)
        tableView.backgroundColor = .clear
        view.backgroundColor = .appVeryLightGray
        tableView.noSeperator()
        tabBarItem.image = #imageLiteral(resourceName: "More")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActionBar(.withTitle(Str.more))
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
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoreDataRep.allCases[indexPath.row].viewController
        let presentation = MoreDataRep.allCases[indexPath.row].presentationType
        if presentation == .popover {
            present(vc, animated: true, completion: nil)
        } else {
            navigationController?.pushViewController(vc, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
