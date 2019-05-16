//
//  SearchViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import PanModal
import RxSwift
import UIKit
final class SearchViewController: UIViewController, PanModalPresentable,StyledActionBar {
    var panScrollable: UIScrollView? {
        return tableView
    }

    @IBOutlet var tableView: UITableView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle("بحث"))
        setupTableView()
    }
    private func setupTableView(){
        tableView.register(UINib(nibName: CountryTableCell.cellId, bundle: nil), forCellReuseIdentifier: CountryTableCell.cellId)
        
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: CountryTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! CountryTableCell)
                mycell.setCellData((model, #imageLiteral(resourceName: "united-kingdom") ))
            }.disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.asObservable().subscribe({[unowned self] event in
            switch event.event{
            case .next(let indexPath):
                try! AppNavigator().push(.visaRequirement)
            default:
                break
                
            }
        }).disposed(by: disposeBag)
    }
}
