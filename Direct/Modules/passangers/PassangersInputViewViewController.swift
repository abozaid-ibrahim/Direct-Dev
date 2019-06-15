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

    var tabs = [(ViewPagerTab, PassangerFormController)]()
    var pager: ViewPager?

    @IBOutlet private var containerView: UIView!
    @IBOutlet var headerLbl: UILabel!
    var visaInfo: VisaRequestParams?
    var successInputIndexes: [Int] = []
    private let disposeBag = DisposeBag()
    var defaultTabSelection = PublishSubject<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Str.passangersInfo
        guard let info = visaInfo else { return }
        setHeader(info)
        headerLbl.setYellowGradient()
        setupTabbar(info)
        setupPager()
    }

    func setupPager() {
        pager = ViewPager(viewController: self,containerView: containerView)

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

    private func setHeader(_ info: VisaRequestParams) {
        if let type = info.visatypeText {
            headerLbl.text = "\(info.countryName!)-\(type)-\(info.no_of_passport!) \("passangers".localized)"
        }
    }

    private func addTabItemAndController(_ placeholder: String, _ info: VisaRequestParams, index: Int) {
        let tabController = PassangerFormController()
        tabController.countryName = info.countryName
        tabController.countryId = info.country_id
        tabController.index = index
        let item = ViewPagerTab(title: "\(placeholder) \(1 + index )", image: #imageLiteral(resourceName: "rightGray"))

        tabController.successIndex.subscribe(onNext: { [unowned self] value in
            self.successInputIndexes.append(value)
            if !self.selectNextTab() {
                try! AppNavigator().push(.successVisaReqScreen(nil))
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        tabs.append((item, tabController))
    }

    private func setupTabbar(_ info: VisaRequestParams) {
        for index in 0 ..< Int(info.no_of_adult)! {
            addTabItemAndController(Str.adult, info, index: index)
        }
        for index in 0 ..< Int(info.no_of_child)! {
            addTabItemAndController(Str.child, info, index: index)
        }

    }

    private func selectNextTab() -> Bool {
        for tab in tabs {
            let index = (tab.1.index!)
            if successInputIndexes.contains(index) {
                tabs[index].0.image = #imageLiteral(resourceName: "path4")
            } else {
            
                self.willMoveToControllerAtIndex(index: index)
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
        let vc = tabs[position].1
//            vc.itemText = "\(tabs[position].0.title)"

        return vc
    }

    func tabsForPages() -> [ViewPagerTab] {
        return tabs.map { $0.0 }
    }

    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension PassangersInputViewViewController: ViewPagerDelegate {
    func willMoveToControllerAtIndex(index: Int) {
        print("Moving to page \(index)")
    }

    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
    }
}
