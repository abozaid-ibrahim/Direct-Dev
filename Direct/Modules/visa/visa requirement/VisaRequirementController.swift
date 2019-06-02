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
    //    let dataSource = RXTABleviewdataou<SectionModel<String, Double>>(
    //        configureCell: { _, tv, _, _ in
    //            let cell = tv.dequeueReusableCell(withIdentifier: VisaRequirementTableCell.cellId) as! VisaRequirementTableCell
    //            cell.textlbl.text = "الجواز الأصل"
    //            return cell
    //        },
    //        titleForHeaderInSection: { dataSource, sectionIndex in
    //            dataSource[sectionIndex].model
    //        }
//    )
    
    // MARK: IBuilder ====================================>>
    
    @IBOutlet var headerIconView: UIImageView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var countryNameLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    //===================================================<<
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    private let data = PublishSubject<[Requirement]>()
    var totalCost: String?

    var country: String?
    internal let disposeBag = DisposeBag()
    
    let network = ApiClientFacade()
    var x: [VisaService]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitleAndX("متطلبات التأشيرة"))
        setDatasource()
        getData()
    }
    
    private func getData() {
        guard let id = country else {
            return
        }
        Progress.show()

        network.getVisaRequirements(country: id).subscribe(onNext: { [unowned self] req in
            
            self.data.onNext(req.requirementPage.first?.requirements ?? [])
            if let obj = req.requirementPage.first{
                self.headerIconView.setImage(url: obj.flagURL ?? "")
                self.countryNameLbl.text = obj.name
                self.descLbl.text = ""
            }
           
            Progress.hide()
        }, onError: { _ in
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    @IBAction func requestAction(_: Any) {
        try! AppNavigator().push(.paymentMethod(totalCost: totalCost))
    }
}

extension VisaRequirementController: UITableViewDelegate {
    func setDatasource() {
        tableView.defaultSeperator()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: VisaRequirementTableCell.cellId, bundle: nil), forCellReuseIdentifier: VisaRequirementTableCell.cellId)
        data.bind(to: tableView.rx.items(cellIdentifier: VisaRequirementTableCell.cellId)) { _, model, cell in
            let mycell = (cell as! VisaRequirementTableCell)
            mycell.setCellData(model)
            
        }.disposed(by: disposeBag)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // to prevent swipe to delete behavior
    func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
//    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
//        return 45
//    }
//
//    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
//        let header = Bundle.main.loadNibNamed("RequireVisaSectionHeader", owner: nil)!.first as! RequireVisaSectionHeader
//        header.setData(text: "المدة المتوقعة لصدور التأشيرة", img: #imageLiteral(resourceName: "icons8Fingerprint"))
//        return header
//    }
}
