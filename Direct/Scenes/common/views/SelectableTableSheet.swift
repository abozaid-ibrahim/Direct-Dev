//
//  SelectableTableSheet.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import PanModal
import RxSwift
import UIKit
final class SelectableTableSheet: UIViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }

    
    @IBOutlet var tableView: UITableView!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: SingleRowTableCell.cellId, bundle: nil), forCellReuseIdentifier: SingleRowTableCell.cellId)

        Observable<[String]>.just(Array(dataList[0 ... 3]))
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! SingleRowTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}


protocol Selectable {
    associatedtype DataModel
    associatedtype TableCell
    func setTableDataAndCell(data:[DataModel],cell:TableCell)
    
}
