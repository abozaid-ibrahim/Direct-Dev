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
    
    // MARK: Dependencies
    
    var visaInfo: VisaRequestParams?
    var successInputIndexes: [Int] = []
    var reqID: String?
    var sponsorsIConStatus = PublishSubject<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Str.sponsorsInfo
        guard let info = visaInfo else { return }
        setupTabbar(info)
        setupPager()
    }
    
    private func setupPager() {
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
//        pager?.setDelegate(delegate: self)
        pager?.build()
    }
    
    private var sponsorsNumber: Int {
        guard let info = visaInfo else { return 0 }
        return Int(info.no_of_passport)!
    }
    
    private func addTabItemAndController(_ placeholder: String, _ info: VisaRequestParams, index: Int, _ relation: String) {
        let sponsorVC = SponserFormController()
        sponsorVC.relationType = relation
        sponsorVC.index = index
        sponsorVC.reqID = reqID
        sponsorVC.cid = info.country_id
        sponsorVC.formResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.successInputIndexes.append(index)
                self.tabs[index].0.image = #imageLiteral(resourceName: "rightGreenIcon")
                self.pager?.updateTabViewImage(of: index, with: #imageLiteral(resourceName: "rightGreenIcon"))
                self.onCompleteForm(with: value, for: relation)
            }).disposed(by: disposeBag)
        
        let item = ViewPagerTab(title: "\(placeholder) \(1 + index)", image: #imageLiteral(resourceName: "rightGray"))
        tabs.append((item, sponsorVC))
    }
    
    private func onCompleteForm(with result: UploadSponserInfoResponse, for type: String) {
        switch type {
        case RelationIDS.family.rawValue:
            sponsorsIConStatus.onNext(true)
            navigationController?.popViewController()
        case RelationIDS.others.rawValue:
            sponsorsIConStatus.onNext(true)
            let formsIsCompleted = selectNextTab()
            if formsIsCompleted {
                navigationController?.popViewController()
            }
            
        case RelationIDS.friends.rawValue:
            if sponsorsNumber == successInputIndexes.count {
                sponsorsIConStatus.onNext(true)
                navigationController?.popViewController()
            } else {
                if !selectNextTab() {
                    navigationController?.popViewController()
                }
            }
        default:
            print("unregistered relation type")
        }
    }
    
    private func setupTabbar(_ info: VisaRequestParams) {
        print(Int(info.no_of_passport)!)
        guard let travelersRelationId = info.relation_with_travelers else {
            addTabItemAndController(Str.sponser, info, index: 0, RelationIDS.family.rawValue)
            return
        }
        if travelersRelationId == RelationIDS.family.rawValue { // family
            addTabItemAndController(Str.sponser, info, index: 0, travelersRelationId)
        } else if travelersRelationId == RelationIDS.friends.rawValue { // friends
            for index in 0 ..< Int(info.no_of_passport)! {
                addTabItemAndController(Str.sponser, info, index: index, travelersRelationId)
            }
            
        } else if travelersRelationId == RelationIDS.others.rawValue { // others
            for index in 0 ..< Int(info.no_of_passport)! {
                addTabItemAndController(Str.sponser, info, index: index, travelersRelationId)
            }
        }
    }
    
    private func selectNextTab() -> Bool {
        for tab in tabs {
            let index = (tab.1.index!)
            if successInputIndexes.contains(index) {
                tabs[index].0.image = #imageLiteral(resourceName: "path4")
                pager?.updateTabViewImage(of: index, with: #imageLiteral(resourceName: "rightGreenIcon"))
                
            } else {
                pager?.displayViewController(atIndex: index)
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
        return tabs[position].1
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs.map { $0.0 }
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

// extension SponsersViewController: ViewPagerDelegate {
//    func willMoveToControllerAtIndex(index: Int) {
//        print("Moving to page \(index)")
//    }
//
//    func didMoveToControllerAtIndex(index: Int) {
//        print("Moved to page \(index)")
//    }
// }
