//
//  VisaRequirementController.swift
//  Direct
//
//  Created by abuzeid on 4/27/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PanModal
import RxDataSources

final class VisaRequirementController: UIViewController, PanModalPresentable,StyledActionBar {
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: VisaRequirementTableCell.cellId ) as!  VisaRequirementTableCell
            //            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            cell.textlbl.text = "\(element) @ row \(indexPath.row)"
            return cell
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
    }
    )
    
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var tableView:UITableView!
    private let data:Observable<String> = Observable.from(dataList)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitleAndX("Visa Req"))
        tableView.register(UINib(nibName: VisaRequirementTableCell.cellId, bundle: nil), forCellReuseIdentifier: VisaRequirementTableCell.cellId)
        
        setDatasource()
        
    }
    
    
    @IBAction func requestAction(_ sender: Any) {
    }
}
struct CustomData {
    var anInt: Int
    var aString: String
    var aCGPoint: CGPoint
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}
extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
extension VisaRequirementController: UITableViewDelegate {
    
    func setDatasource() {
        
        let dataSource = self.dataSource
        
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                1.0,
                2.0,
                3.0
                ]),
            SectionModel(model: "Second section", items: [
                1.0,
                2.0,
                3.0
                ]),
            SectionModel(model: "Third section", items: [
                1.0,
                2.0,
                3.0
                ])
            ])
        
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                //                DefaultWireframe.presentAlert("Tapped `\(pair.1)` @ \(pair.0)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // to prevent swipe to delete behavior
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print("\(tableView.numberOfSections) - \(section)")
        let header  = Bundle.main.loadNibNamed("RequireVisaSectionHeader", owner: nil)!.first as! RequireVisaSectionHeader
header.setData(text: "Fuck", img: #imageLiteral(resourceName: "p"))
        return header
    }
}
