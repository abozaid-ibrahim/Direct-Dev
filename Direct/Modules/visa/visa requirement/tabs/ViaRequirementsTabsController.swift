//
//  ViaRequirementsTabsController.swift
//  Direct
//
//  Created by abuzeid on 7/6/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
import XLPagerTabStrip

class ViaRequirementsTabsController: UIViewController,StyledActionBar {
    internal let disposeBag = DisposeBag()
    private let viewModel = ViaRequirementsTabsViewModel()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        viewModel.countriesList.subscribe(onNext: { [unowned self] value in
            let tb = value.map {
                ReqTabItemViewController(itemInfo: IndicatorInfo(title: $0.countryName, image: nil, userInfo: $0.flag),
                                         country: $0.country_id ?? "0")
            }
            self.addTabsView(tabs: tb)
        }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupActionBar(.withTitle( Str.visaRequirement.localized()))
    }
    private func addTabsView(tabs: [ReqTabItemViewController]) {
        let vc = VisaTabsController(tabs: tabs)
        add(vc)
        view.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            vc.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            vc.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
}
