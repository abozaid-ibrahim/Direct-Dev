//
//  SelectableTableSheet.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit

import UIKit
import RxSwift
import PanModal
final class SelectableTableSheet: UIViewController,PanModalPresentable {
    var panScrollable: UIScrollView?{
        return  tableView
    }
    @IBOutlet weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: SingleRowTableCell.cellId, bundle: nil), forCellReuseIdentifier: SingleRowTableCell.cellId)

        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: SingleRowTableCell.cellId)) { row, model, cell  in
                let mycell = (cell as! SingleRowTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)
        
    }
}
