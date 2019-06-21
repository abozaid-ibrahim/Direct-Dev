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

    private let data = PublishSubject<[ReqInformation]>()
    private var datalist: [ReqDataSection] = []
    var visaData: VisaRequestParams?
    internal let disposeBag = DisposeBag()

    private let network = ApiClientFacade()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitleAndX("متطلبات التأشيرة"))
        setDatasource()
        getDataRemotely()
    }

    @IBAction func requestAction(_: Any) {
        try! AppNavigator().push(.confirmatonVisa(visaData!))
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
        data.subscribe(onNext: { [unowned self] value in
            self.datalist.removeAll()
            self.datalist.append(contentsOf:value.map { ReqDataSection($0) })
            self.tableView.reloadData()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }

    private func getDataRemotely() {
        guard let id = visaData?.country_id else {
            return
        }
        Progress.show()

        network.getVisaRequirements(country: id).subscribe(onNext: { [unowned self] response in

            guard let requirement = response.requirementPage?.first else { return }
            var sum = requirement.requirements ?? []
            sum.append(contentsOf: requirement.informations ?? [])
            self.data.onNext(sum)

            // set header data
            self.headerIconView.setImage(with: requirement.flagURL ?? "")
            self.countryNameLbl.text = requirement.name
            self.descLbl.text = self.visaData?.visatypeText

            Progress.hide()
        }, onError: { _ in
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VisaRequirementTableCell.cellId) as? VisaRequirementTableCell else {
                return UITableViewCell()
            }

            cell.setCellData(datalist[indexPath.section].data)

            return cell
        } else {
            //this is for expanded cells
            let cell = tableView.dequeueReusableCell(withIdentifier: ReqDescTableCell.cellId) as! ReqDescTableCell
            cell.setCellData(datalist[indexPath.section].data.desc ?? "")
            return cell
        }
    }
}

extension VisaRequirementController: UITableViewDelegate {
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

class ReqDataSection {
    var opened: Bool = false
    var data: ReqInformation
    init(_ req: ReqInformation) {
        data = req
        opened = false
    }
}
