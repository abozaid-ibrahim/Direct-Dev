//
//  PassangersInputViewViewController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit
class PassangersInputViewViewController: UIViewController {
    /// Description

    @IBOutlet private var containerView: UIView!
    private let disposeBag = DisposeBag()

    @IBOutlet var headerLbl: UILabel!
    private var tabs = [(tab: ViewPagerTab, vc: PassangerFormController)]()
    private var pager: ViewPager?
    var visaInfo: VisaRequestParams?
    var successInputIndexes: [Int] = []
    var sucessIndex = PublishSubject<[Int]>()
    var defaultTabSelection: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Str.passangersInfo.localized()
        guard let info = visaInfo else { return }
        setHeader(info)
        headerLbl.setYellowGradient()
        setupTabbar(info)
        setupPager()
    }

    func setupPager() {
        pager = ViewPager(viewController: self, containerView: containerView)
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

    private func setHeader(_ info: VisaRequestParams) {
        if let type = info.visatypeText {
            headerLbl.text = "\(info.countryName!)-\(type)-\(info.no_of_passport!) \("passangers".localized)"
        }
    }

    private func addTabItemAndController(_ placeholder: String, _ info: VisaRequestParams, writingIndex: Int,totalIndex:Int) {
        let tabController = PassangerFormController()
        tabController.countryName = info.countryName
        tabController.countryId = info.country_id
        tabController.formType = info.form_type
        tabController.index = totalIndex
        tabController.visaReqID = info.requestID
        tabController.visaType = info.visatype
        tabController.isChild = Str.child == placeholder
        let item = ViewPagerTab(title: "\(placeholder) \(1 + writingIndex)", image: #imageLiteral(resourceName: "rightGray"))

        tabController.successIndex
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.successInputIndexes.append(value)
                self.pager?.updateTabViewImage(of: value, with: #imageLiteral(resourceName: "rightGreenIcon"))
                self.sucessIndex.onNext(self.successInputIndexes)
                if !self.selectNextTab() {
                    self.navigationController?.popViewController()
                }
            }).disposed(by: disposeBag)
        tabs.append((item, tabController))
    }

    private func setupTabbar(_ info: VisaRequestParams) {
        var globalIndex = -1
        for index in 0 ..< Int(info.no_of_adult)! {
            globalIndex += 1
            addTabItemAndController(Str.adult, info, writingIndex: index, totalIndex: globalIndex)
        }
        for index in 0 ..< Int(info.no_of_child)! {
            globalIndex += 1
            addTabItemAndController(Str.child, info, writingIndex: index, totalIndex: globalIndex)
        }
    }

    private func selectNextTab() -> Bool {
        for index in 0..<tabs.count {
            if successInputIndexes.contains(index) {
                tabs[index].tab.image = #imageLiteral(resourceName: "path4")
                pager?.updateTabViewImage(of: index, with: #imageLiteral(resourceName: "rightGreenIcon"))
            } else {
                pager?.displayViewController(atIndex: index)
                return true
            }
        }
        return false
    }
}

extension PassangersInputViewViewController: ViewPagerDataSource {
    func numberOfPages() -> Int {
        return tabs.count
    }

    func viewControllerAtPosition(position: Int) -> UIViewController {
        return tabs[position].vc
    }

    func tabsForPages() -> [ViewPagerTab] {
        return tabs.map { $0.tab }
    }

    func startViewPagerAtIndex() -> Int {
        return defaultTabSelection
    }
}
