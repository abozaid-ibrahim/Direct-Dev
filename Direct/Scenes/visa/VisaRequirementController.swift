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
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { _, tv, _, _ in
            let cell = tv.dequeueReusableCell(withIdentifier: VisaRequirementTableCell.cellId) as! VisaRequirementTableCell
            cell.textlbl.text = "الجواز الأصل"
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            dataSource[sectionIndex].model
        }
    )

    var panScrollable: UIScrollView? {
        return tableView
    }

    internal let disposeBag = DisposeBag()
    @IBOutlet private var tableView: UITableView!
    private let data: Observable<String> = Observable.from(dataList)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitleAndX("متطلبات التأشيرة"))
        tableView.register(UINib(nibName: VisaRequirementTableCell.cellId, bundle: nil), forCellReuseIdentifier: VisaRequirementTableCell.cellId)

        setDatasource()
    }

    @IBAction func requestAction(_: Any) {
        try! AppNavigator().push(.newDirectVisa)
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
            SectionModel(model: "الأوراق المطلوبة", items: [
                1.0,
                2.0,
                3.0,
            ]),
            SectionModel(model: "تتطلب بصمة", items: [
                1.0,
                2.0,
                3.0,
            ]),
            SectionModel(model: "Third section", items: [
                1.0,
                2.0,
                3.0,
            ]),
        ])

        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx
            .itemSelected
            .map { indexPath in
                (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { _ in
                //                DefaultWireframe.presentAlert("Tapped `\(pair.1)` @ \(pair.0)")
            })
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }

    // to prevent swipe to delete behavior
    func tableView(_: UITableView, editingStyleForRowAt _: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 45
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("RequireVisaSectionHeader", owner: nil)!.first as! RequireVisaSectionHeader
        header.setData(text: "المدة المتوقعة لصدور التأشيرة", img: #imageLiteral(resourceName: "icons8Fingerprint"))
        return header
    }
}
