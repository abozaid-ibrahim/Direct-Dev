//
//  PassangersInputViewViewController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

protocol PassangerInputsConnection {
    func submit()
}
class PassangersInputViewViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var tabbarView: TabBar!
    var visaInfo: VisaRequestParams?
    var successInputIndexes:[Int] = []
    var successIndex = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "معلومات المسافرين"
        setupTabbar()
    }
    
    var tabs: [(TAB, PassangerFormController)] = []
    private func setupTabbar() {
        guard let info = visaInfo else { return }
        
        for index in 0..<Int(info.no_of_adult)! {
            let tab1VC = PassangerFormController()
            tab1VC.countryId = info.country_id
            tab1VC.index = index
            let tab1 = ("بالغ" + " " + "\(index + 1)", { [weak self] in
                self?.selectTab(index, tab1VC)
            })
            
            tabs.append((tab1, tab1VC))
        }
        for index in 0..<Int(info.no_of_child)! {
            let tab1VC = PassangerFormController()
            let tab1 = ("طفل" + " " + "\(index + 1)", { [weak self] in
                self?.selectTab(index, tab1VC)
            })
            tabs.append((tab1 , tab1VC))
        }
        let tabbar = TabBar(tabs: tabs.map { $0.0 })
        tabbarView.addSubview(tabbar)
        tabbar.sameBoundsTo(parentView: tabbarView)
        if let first  = tabs.first{
            selectTab(0, first.1)
            
        }
        successIndex.subscribe(onNext: {[unowned self] value in
            self.successInputIndexes.append(value)
            for tab in self.tabs{
                if !self.successInputIndexes.contains((tab.1.index ?? -1 ) ){
                    self.selectTab((tab.1.index ?? -1), tab.1)
                    break
                }
            }
            }, onError: nil, onCompleted: nil, onDisposed:  nil).disposed(by: disposeBag)
    }
    
    private func selectTab(_ index: Int, _ tab1VC: PassangerFormController) {
        /* 1 if item is subview//goto 3
          show item
         if Not
         add item then show
         */
        
        if !containerView.subviews.contains(tab1VC.view) {
            // add
            addChild(tab1VC)
            containerView.addSubview(tab1VC.view)
            tab1VC.view.sameBoundsTo(parentView: containerView)
        }
        
        for (i,item) in tabs.enumerated() {
            item.1.view.isHidden = index == i ? false : true
        }
    }
   
}
