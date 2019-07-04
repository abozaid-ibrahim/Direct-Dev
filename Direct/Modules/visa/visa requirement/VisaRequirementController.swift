//
//  VisaRequirementController.swift
//  Direct
//
//  Created by abuzeid on 4/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class VisaRequirementController: UIViewController, PanModalPresentable, StyledActionBar {
    // MARK: IBuilder ====================================>>

    @IBOutlet private var headerIconView: UIImageView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var countryNameLbl: UILabel!
    @IBOutlet private var descLbl: UILabel!
    //===================================================<<
    var panScrollable: UIScrollView? {
        return tableView
    }

    private let viewModel = VisaRequirementsViewModel()
    private var datalist: [ReqDataSection] = []
    var visaData: VisaRequestParams?
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        countryNameLbl.font = UIFont.appBoldFontWith(size: 17)
        setupActionBar(.withTitleAndX(Str.visaRequirement))
        tableView.separatorColor = UIColor.appVeryLightGray
        setDatasource()
        viewModel.getDataRemotely(for: visaData?.country_id)
        viewModel.headerData.subscribe(onNext: { [unowned self] value in
            self.setHeaderData(with: value)
        }).disposed(by: disposeBag)
    }

    @IBAction func requestAction(_: Any) {
        try! AppNavigator().push(.confirmatonVisa(visaData!, reqID: visaData?.requestID ?? ""))
    }
}

extension VisaRequirementController {
    func setDatasource() {
        tableView.defaultSeperator()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.registerNib(VisaRequirementTableCell.cellId)
        tableView.registerNib(ReqDescTableCell.cellId)
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.data.subscribe(onNext: { [unowned self] value in
            self.datalist.removeAll()
            self.datalist.append(contentsOf: value)
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

    private func setHeaderData(with requirement: RequirementPage) {
        headerIconView.setImage(with: requirement.flagURL ?? "")
        countryNameLbl.text = requirement.name
        descLbl.text = visaData?.visatypeText
    }
}

extension VisaRequirementController: UITableViewDataSource {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VisaRequirementTableCell.cellId) as? VisaRequirementTableCell else {
                return UITableViewCell()
            }
            cell.expandRow.isHidden = datalist[indexPath.section].hideAccessory
            cell.setCellData((datalist[indexPath.section].data, datalist[indexPath.section].hideAccessory))

            return cell
        } else {
            //this is for expanded cells
            let cell = tableView.dequeueReusableCell(withIdentifier: ReqDescTableCell.cellId) as! ReqDescTableCell
            let model = datalist[indexPath.section].data
            cell.setCellData((model.desc ?? "", model.image))
            return cell
        }
    }
}

extension VisaRequirementController: UITableViewDelegate {
    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if datalist[indexPath.section].hideAccessory {
            return
        }
        if datalist[indexPath.section].opened {
            datalist[indexPath.section].opened = false
        } else {
            datalist[indexPath.section].opened = true
        }
        let set = IndexSet(integer: indexPath.section)
        tableView.reloadSections(set, with: .none)
    }
}
