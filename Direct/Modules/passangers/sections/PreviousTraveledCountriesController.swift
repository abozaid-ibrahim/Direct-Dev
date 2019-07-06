//
//  PreviousTraveledCountriesController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxGesture
import RxSwift
import UIKit

class PreviousTraveledCountriesController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet private var addButton: UIButton!
    private let disposeBag = DisposeBag()
    var tableHeight = PublishSubject<CGFloat>()
    var countries = PublishSubject<[String]>()
    var items: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.font = .appBoldFontWith(size: 15)
        addButton.titleLabel?.font = UIFont.appRegularFontWith(size: 15)

        setupTable()
        addButton.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.showEnterField()
            }).disposed(by: disposeBag)
        tableView.rx.observeWeakly(CGSize.self, contentSizeKey).subscribe(onNext: { [unowned self] _ in
            self.tableHeight.onNext(self.tableView.contentSize.height + self.headerHeight)
        }).disposed(by: disposeBag)
    }

    let headerHeight = CGFloat(90)
    private let contentSizeKey = "contentSize"

    func setupTable() {
        countries
            .bind(to: tableView.rx.items(cellIdentifier: CountryCell.id, cellType: CountryCell.self)) { pos, element, cell in
                cell.textLbl.text = element
                cell.deleteBtn.rx.tapGesture().when(.recognized)
                    .subscribe(onNext: { _ in
                        self.items.remove(at: pos)
                        self.countries.onNext(self.items)
                    }).disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }

    func showEnterField() {
        let picker = AddCountryViewController()
        picker.country.subscribe(onNext: {[unowned self] value in
            self.items.append(value)
            self.countries.onNext(self.items)
        }).disposed(by: disposeBag)
        try! AppNavigator().push(picker)
    }
}

class CountryCell: UITableViewCell {
    let disposeBag = DisposeBag()
    static let id = "CountryCell"
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var deleteBtn: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
