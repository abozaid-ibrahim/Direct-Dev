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
    
    @IBOutlet var headerIconView: UIImageView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var countryNameLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    //===================================================<<
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    private let data = PublishSubject<[Requirement]>()
    
    var visaData:VisaRequestParams?
    internal let disposeBag = DisposeBag()
    
    let network = ApiClientFacade()
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
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: VisaRequirementTableCell.cellId, bundle: nil), forCellReuseIdentifier: VisaRequirementTableCell.cellId)
        data.bind(to: tableView.rx.items(cellIdentifier: VisaRequirementTableCell.cellId)) { _, model, cell in
            let mycell = (cell as! VisaRequirementTableCell)
            mycell.setCellData(model)
        }.disposed(by: disposeBag)
     
    }
    
    private func getDataRemotely() {
        guard let id = visaData?.country_id else {
            return
        }
        Progress.show()
        
        network.getVisaRequirements(country: id).subscribe(onNext: { [unowned self] req in
            
            self.data.onNext(req.requirementPage.first?.requirements ?? [])
            if let obj = req.requirementPage.first {
                self.headerIconView.setImage(url: obj.flagURL ?? "")
                self.countryNameLbl.text = obj.name
                self.descLbl.text = ""
            }
            
            Progress.hide()
        }, onError: { _ in
            Progress.hide()
        }, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

