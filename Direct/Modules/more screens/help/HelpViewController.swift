//
import PanModal
import RxSwift
//  HelpViewController.swift
//  Direct
//
//  Created by abuzeid on 5/1/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//
import UIKit
final class HelpViewController: UIViewController, PanModalPresentable, StyledActionBar {
    var panScrollable: UIScrollView? {
        return tableView
    }

    private let viewModel = HelpViewModel()
    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActionBar(.withTitle("مساعدة"))
        tableView.registerNib(HelpTableCell.cellId)
        view.backgroundColor = UIColor.appOffWhite
        tableView.backgroundColor = .appOffWhite

        viewModel.faqsText
            .bind(to: tableView.rx.items(cellIdentifier: HelpTableCell.cellId, cellType: HelpTableCell.self)) { _, model, cell in
                cell.setCellData(model)
            }.disposed(by: disposeBag)
    }
}

import RxDataSources
import RxSwift

class HelpViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    var showProgress = PublishSubject<Bool>()
    private let network = ApiClientFacade()

    var faqsText: Observable<[FAQPage]> {
        return Observable<[FAQPage]>.create { observer in
            self.showProgress.onNext(true)
            self.network.getFaqs().subscribe(onNext: { [unowned self] value in
                observer.onNext(value.faqPage ?? [])
                self.showProgress.onNext(false)
            }).disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
