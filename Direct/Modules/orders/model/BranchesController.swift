//
//  BranchesController.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class BranchesController: UIViewController, StyledActionBar {
    internal let disposeBag = DisposeBag()
    @IBOutlet private var tableView: UITableView!
    private let viewModel = BranchesViewModel()
    fileprivate var datalist: [BranchesSection] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .appVeryLightGray
        view.backgroundColor = .appVeryLightGray
        setupActionBar(.withTitle(Str.branches))
        tableView.registerNib(BranchesDescTableCell.cellId)
        tableView.registerNib(BranchesTableCell.cellId)
        viewModel.branches.map { $0?.branch }.filterNil()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] value in
                self.datalist = value.map { BranchesSection($0) }
                self.datalist.first?.opened = true
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.defaultSeperator()
    }
}

extension BranchesController: UITableViewDataSource {
    public func numberOfSections(in _: UITableView) -> Int {
        return datalist.count
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datalist[section].opened {
            return 2
        }
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { //this is always the header
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BranchesTableCell.cellId) as? BranchesTableCell else {
                return UITableViewCell()
            }
            let model = datalist[indexPath.section]
            cell.setCellData(model.data.name ?? "")

            return cell
        } else {
            //this is for expanded cells
            let cell = tableView.dequeueReusableCell(withIdentifier: BranchesDescTableCell.cellId) as! BranchesDescTableCell
            let model = datalist[indexPath.section]
            cell.setCellData(model)
            return cell
        }
    }
}

extension BranchesController: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if datalist[indexPath.section].opened {
            datalist[indexPath.section].opened = false
        } else {
            datalist[indexPath.section].opened = true
        }
        let set = IndexSet(integer: indexPath.section)
        tableView.reloadSections(set, with: .none)
    }
}

class BranchesSection {
    var opened: Bool = false
    var data: Branch
    init(_ req: Branch) {
        data = req
    }
}
