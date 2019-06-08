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
    @IBOutlet private  weak var tabbarWidthConstrain: NSLayoutConstraint!
    var tabbar: TabBar!
    var visaInfo: VisaRequestParams?
    var successInputIndexes:[Int] = []
    private let disposeBag = DisposeBag()
    var defaultTabSelection:Int?
    
    
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
            
            tab1VC.successIndex.subscribe(onNext: {[unowned self] value in
                self.successInputIndexes.append(value)
                if !self.selectNextTab(){
                    try! AppNavigator().push(.successVisaReqScreen(nil))
                }
                }, onError: nil, onCompleted: nil, onDisposed:  nil).disposed(by: disposeBag)
            tabs.append((tab1, tab1VC))
        }
        for index in 0..<Int(info.no_of_child)! {
            let tab1VC = PassangerFormController()
            let tab1 = ("طفل" + " " + "\(index + 1)", { [weak self] in
                self?.selectTab(index, tab1VC)
            })
            tabs.append((tab1 , tab1VC))
        }
        if tabs.count > 3{
            tabbarWidthConstrain.constant = view.bounds.width
        }else{
            tabbarWidthConstrain.constant = CGFloat(tabs.count * 80)
        }
         tabbar = TabBar(tabs: tabs.map { $0.0 })
        tabbar.tabsIcon.forEach{$0.image = #imageLiteral(resourceName: "rightGreen")}
        tabbarView.addSubview(tabbar)
        tabbar.sameBoundsTo(parentView: tabbarView)
       
       
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if defaultTabSelection != nil{
            selectTab(defaultTabSelection ?? 0, tabs[defaultTabSelection ?? 0].1)
        }
    }
    private func selectNextTab()->Bool{
        
        for tab in self.tabs{
            let index = (tab.1.index! )
            if self.successInputIndexes.contains(index){
                tabbar.tabsIcon[index].image = #imageLiteral(resourceName: "path4")
            }else{
                self.selectTab(index, tab.1)
                return true
            }
        }
        return false
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
        tabbar.didSelectTab(index: index)
    }
   
}
