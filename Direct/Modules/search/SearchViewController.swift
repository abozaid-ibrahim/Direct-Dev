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
final class SearchViewController: UIViewController, PanModalPresentable, StyledActionBar {
    var panScrollable: UIScrollView? {
        return nil //tableView
    }

    var shortFormHeight: PanModalHeight = .maxHeightWithTopInset(20)

    var selectedItem = PublishSubject<NewVisaServices>()
    private let viewModel = SearchCountriesViewModel()
    @IBOutlet var tableView: UITableView!
    internal let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.defaultSeperator()
        viewModel.viewDidLoad()
        Progress.show()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: CountryTableCell.cellId, bundle: nil), forCellReuseIdentifier: CountryTableCell.cellId)
        viewModel.countriesList.take(1).subscribe { _ in
            Progress.hide()
        }.disposed(by: disposeBag)
        viewModel.countriesList
            .bind(to: tableView.rx.items(cellIdentifier: CountryTableCell.cellId)) { _, model, cell in
                let mycell = (cell as! CountryTableCell)
                mycell.setCellData(model)
            }.disposed(by: disposeBag)

        tableView.rx
            .modelSelected(NewVisaServices.self)
            .subscribe(onNext: { value in
                self.selectedItem.onNext(value)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
