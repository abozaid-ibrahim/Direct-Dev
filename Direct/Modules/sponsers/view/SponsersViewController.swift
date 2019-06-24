//
//  SponsersViewController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

final class SponsersViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var tabs = [(ViewPagerTab, SponserFormController)]()
    private var pager: ViewPager?
    var visaInfo: VisaRequestParams?
    var successInputIndexes: [Int] = [] /// friends all is must, other one is must
    var reqID:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "معلومات المتكفلين"
        guard let info = visaInfo else { return }
        setupTabbar(info)
        setupPager()
    }
    
    func setupPager() {
        pager = ViewPager(viewController: self)
        let options = ViewPagerOptions()
        options.tabType = .imageWithText
        options.distribution = .normal
        options.tabViewBackgroundHighlightColor = UIColor.clear
        options.tabViewBackgroundDefaultColor = UIColor.white
        options.tabViewTextDefaultColor = .gray
        options.tabViewTextHighlightColor = .black
        options.tabIndicatorViewBackgroundColor = UIColor.appPumpkinOrange
        options.viewPagerTransitionStyle = .scroll
        options.tabViewHeight = 50
        pager?.setOptions(options: options)
        pager?.setDataSource(dataSource: self)
        pager?.setDelegate(delegate: self)
        pager?.build()
    }
    
    private func addTabItemAndController(_ placeholder: String, _ info: VisaRequestParams, index: Int, _ relation: String) {
        let tabController = SponserFormController()
        tabController.relationType = relation
        tabController.index = index
        tabController.reqID = reqID
        tabController.cid = info.country_id
        let item = ViewPagerTab(title: "\(placeholder) \(1 + index)", image: #imageLiteral(resourceName: "rightGray"))
        tabs.append((item, tabController))
    }
    
    private func setupTabbar(_ info: VisaRequestParams) {
        guard let id = info.relation_with_travelers else { return }
        if id == RelationIDS.family.rawValue { // family
            addTabItemAndController(Str.firstSponser, info, index: 0, id)
        } else if id == RelationIDS.friends.rawValue { // friends
            for index in 0 ..< Int(info.no_of_passport)! {
                addTabItemAndController(Str.sponser, info, index: index, id)
            }
            
        } else if id == RelationIDS.others.rawValue { // others
            for index in 0 ..< Int(info.no_of_passport)! {
                addTabItemAndController(Str.sponser, info, index: index, id)
            }
        }
    }
    
    private func selectNextTab() -> Bool {
        for tab in tabs {
            let index = (tab.1.index!)
            if successInputIndexes.contains(index) {
                tabs[index].0.image = #imageLiteral(resourceName: "path4")
            } else {
                willMoveToControllerAtIndex(index: index)
                return true
            }
        }
        return false
    }
}

extension SponsersViewController: ViewPagerDataSource {
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position: Int) -> UIViewController {
        let vc = tabs[position].1
        return vc
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs.map { $0.0 }
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension SponsersViewController: ViewPagerDelegate {
    func willMoveToControllerAtIndex(index: Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}
