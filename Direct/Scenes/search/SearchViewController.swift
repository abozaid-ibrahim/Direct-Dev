//
//  SearchViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift
import PanModal
final class SearchViewController: UIViewController,PanModalPresentable {
    var panScrollable: UIScrollView?{
        return  tableView
    }
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: CountryTableCell.cellId)) { row, model, cell  in
                let mycell = (cell as! CountryTableCell)
                mycell.setCellData((model,UIImage()))
            }.disposed(by: disposeBag)
        
    }
}
