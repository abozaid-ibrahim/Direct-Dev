//
//  PackagesViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import UIKit
import RxSwift

final class PackagesViewController: UIViewController,SwipeUpDismissable {
    private let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame:CGRect?{
        didSet{
            self.view.frame = defaultFrame ?? CGRect.zero
        }
    }
    @IBOutlet weak var tableView: UITableView!
    var dismissable:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dismissable ?? false{
            enableSwipeUpToDismiss()
            
        }
        setupTableDataSource()
        
    }
    private func setupTableDataSource(){
        tableView.registerNib(PackagesTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: PackagesTableCell.cellId)) { row, model, cell  in
                let mycell = (cell as! PackagesTableCell)
            }.disposed(by: disposeBag)
    }
    
}

