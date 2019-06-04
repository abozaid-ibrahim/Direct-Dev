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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addButton.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
            
            }).disposed(by: disposeBag)
    }
    
    func setupTable() {
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.id)
//        let items = Observable.just(
//            (0..<1).map { "\($0)" }
//        )
//        
//        items
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { row, element, cell in
//                guard let myCell = cell as? CountryCell else {return}
////                cCell.textLbl.
//                myCell.textLbl.text = ""
//                
//            }
//            .disposed(by: disposeBag)
        
    }
}

class CountryCell: UITableViewCell {
    static let id = "CountryCell"
    @IBOutlet  var textLbl: UILabel!
    @IBOutlet  var deleteBtn: UIImageView!
}
