//
//  InstituteDetailsController.swift
//  Direct
//
//  Created by abuzeid on 5/2/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

final class InstituteDetailsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var tabsContainer: UIView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        setupTabbar()
    }
    private func setupTableData(){
        tableView.registerNib(InstituteDetailsTableCell.cellId)
        tableView.register(UINib(nibName: InstituteDetailsHeaderView.cellId, bundle: nil), forHeaderFooterViewReuseIdentifier: InstituteDetailsHeaderView.cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setupTabbar(){
        let tab1 = ("حجز دورة", {[weak self] in
            
        })
        let tab2 = ("عن المعهد", {[weak self] in
        })
        
        let tabbar = TabBar(tabs: [tab1, tab2])
        tabsContainer.addSubview(tabbar)
        tabbar.sameBoundsTo(parentView: tabsContainer)
    }
}
extension InstituteDetailsController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: InstituteDetailsTableCell.cellId) as! InstituteDetailsTableCell
        return cell
    }
    
    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed(InstituteDetailsHeaderView.cellId, owner: nil)!.first as! InstituteDetailsHeaderView
        return header
    }
}
