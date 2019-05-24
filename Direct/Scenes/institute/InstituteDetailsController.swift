//
//  InstituteDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

final class InstituteDetailsController: UIViewController, StyledActionBar {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var contentContainer: UIView!
    @IBOutlet var tabsContainer: UIView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withX)
        setupTableData()
        setupTabbar()
    }

    private func setupTableData() {
        tableView.registerNib(InstituteDetailsTableCell.cellId)
        tableView.register(UINib(nibName: InstituteDetailsHeaderView.cellId, bundle: nil), forHeaderFooterViewReuseIdentifier: InstituteDetailsHeaderView.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupTabbar() {
        let tab1 = ("حجز دورة", { [weak self] in

        })
        let tab2 = ("عن المعهد", { [weak self] in
        })

        let tabbar = TabBar(tabs: [tab1, tab2])
        tabsContainer.addSubview(tabbar)
        tabbar.sameBoundsTo(parentView: tabsContainer)
    }
}

extension InstituteDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt _: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstituteDetailsTableCell.cellId) as! InstituteDetailsTableCell
        return cell
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed(InstituteDetailsHeaderView.cellId, owner: nil)!.first as! InstituteDetailsHeaderView
        return header
    }
}
