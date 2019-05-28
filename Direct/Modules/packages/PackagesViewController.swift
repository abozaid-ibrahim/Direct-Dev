//
//  PackagesViewController.swift
//  Direct
//
//  Created by abuzeid on 4/29/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

final class PackagesViewController: UIViewController, SwipeUpDismissable {
    let disposeBag = DisposeBag()
    var dismessed: PublishSubject<Bool> = PublishSubject()
    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var defaultFrame: CGRect? {
        didSet {
            view.frame = defaultFrame ?? CGRect.zero
        }
    }

    @IBOutlet var tableView: UITableView!
    var dismissable: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appOffWhite
        tableView.backgroundColor = .clear
        if dismissable ?? false {
            enableSwipeUpToDismiss()
        }
        setupTableDataSource()
        setOnSelect()
    }

    private func setupTableDataSource() {
        tableView.registerNib(PackagesTableCell.cellId)
        Observable<[String]>.just(dataList)
            .bind(to: tableView.rx.items(cellIdentifier: PackagesTableCell.cellId)) { _, _, cell in
                let mycell = (cell as! PackagesTableCell)
            }.disposed(by: disposeBag)
    }

    private func setOnSelect() {
        tableView.rx.itemSelected.asObservable().subscribe { [unowned self] event in
            switch event.event {
            case let .next(indexPath):
                try! AppNavigator().push(.packageDetails)
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
