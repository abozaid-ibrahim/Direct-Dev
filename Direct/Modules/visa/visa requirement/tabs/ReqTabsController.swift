//
//  ReqTabsController.swift
//  Direct
//
//  Created by abuzeid on 7/7/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation
import XLPagerTabStrip

class VisaTabsController: BaseButtonBarPagerTabStripViewController<VisaRequirementTabCell> {
    private var tabs: [ReqTabItemViewController]
    init(tabs: [ReqTabItemViewController]) {
        self.tabs = tabs
        super.init(nibName: nil, bundle: nil)
        buttonBarItemSpec = ButtonBarItemSpec.nibFile(nibName: VisaRequirementTabCell.id, bundle: Bundle(for: VisaRequirementTabCell.self), width: { _ in
            90
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = ViaRequirementsTabsViewModel()
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor.appMango
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 5
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        settings.style.buttonBarLeftContentInset = 10
        settings.style.buttonBarRightContentInset = 10
        settings.style.buttonBarHeight = 65
//        settings.style.
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel.countriesList.subscribe(onNext: { [unowned self] value in
            self.tabs = value.map { ReqTabItemViewController(itemInfo: IndicatorInfo(title: $0.countryName, image: nil, userInfo: $0.flag), country: $0.country_id ?? "0")
            }
            self.reloadPagerTabStripView()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return tabs
    }
    
    override func configure(cell: VisaRequirementTabCell, for indicatorInfo: IndicatorInfo) {
        cell.iconImage.setImage(with: indicatorInfo.userInfo as! String)
        cell.titleLbl.text = indicatorInfo.title
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged, toIndex > -1, toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider // swiftlint:disable:this force_cast
            UIView.performWithoutAnimation { [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.leftBarButtonItem?.title = child.indicatorInfo(for: me).title
            }
        }
    }
}
