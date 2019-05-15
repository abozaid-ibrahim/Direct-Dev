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
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableData()
        
    }
    private func setupTableData(){
        tableView.registerNib(InstituteDetailsTableCell.cellId)
        tableView.register(UINib(nibName: InstituteDetailsHeaderView.cellId, bundle: nil), forHeaderFooterViewReuseIdentifier: InstituteDetailsHeaderView.cellId)
        tableView.dataSource = self
        tableView.delegate = self
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed(InstituteDetailsHeaderView.cellId, owner: nil)!.first as! InstituteDetailsHeaderView
        return header
    }
}
