//
//  PreviousTraveledCountriesController.swift
//  Direct
//
//  Created by abuzeid on 6/4/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class PreviousTraveledCountriesController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addButton: UIButton!
    private let disposeBag = DisposeBag()
    var countries = PublishSubject<[String]>()
    var items: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        tableView.defaultSeperator()
        addButton.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.showEnterField()
            }).disposed(by: disposeBag)
    }

    func setupTable() {
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.id)
        countries
            .bind(to: tableView.rx.items(cellIdentifier: CountryCell.id, cellType: UITableViewCell.self)) { _, element, cell in
                guard let myCell = cell as? CountryCell else { return }
                myCell.textLbl.text = element
            }
            .disposed(by: disposeBag)
    }

    func showEnterField() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.setTint(color: UIColor.appMango)
        alert.setBackgroudColor(color: UIColor.appVeryLightGray)
        alert.addTextField { (textField) -> Void in
            textField.textColor = UIColor.appVeryLightGray
            textField.placeholder = "الدولة-السنة"
            textField.textColor = UIColor.black
            textField.font = UIFont.appRegularFontWith(size: 14)
        }
        let add = UIAlertAction(title: "تم", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            let text = alert.textFields?.first!.text ?? ""
            self.items.append(text)
            self.countries.onNext(self.items)
        })

        let cancel = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        alert.addAction(add)

        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}

class CountryCell: UITableViewCell {
    static let id = "CountryCell"
    @IBOutlet var textLbl: UILabel!
    @IBOutlet var deleteBtn: UIImageView!
}
