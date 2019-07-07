
//
//  TabItemController.swift
//  Direct
//
//  Created by abuzeid on 7/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import Foundation
import XLPagerTabStrip

class ReqTabItemViewController: UIViewController, IndicatorInfoProvider {
    var itemInfo: IndicatorInfo = "View"
    var country: String
    init(itemInfo: IndicatorInfo, country: String) {
        self.itemInfo = itemInfo
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = VisaRequirementController()
        vc.inputs = .asAtab(country: country)
        addChild(vc)
        view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
