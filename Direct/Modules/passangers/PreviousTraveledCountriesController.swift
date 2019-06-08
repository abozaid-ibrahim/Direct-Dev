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
    @IBOutlet private var addButton: UIButton!{
        didSet{
            addButton.titleLabel?.font  = UIFont.appRegularFontWith(size: 15)
        }
    }
    private let disposeBag = DisposeBag()
    var tableHeight = PublishSubject<CGFloat>()
    var countries = PublishSubject<[String]>()
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        addButton.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.showEnterField()
            }).disposed(by: disposeBag)
        tableView.rx.observeWeakly(CGSize.self, contentSizeKey).subscribe(onNext: { [unowned self] _ in
            self.tableHeight.onNext(self.tableView.contentSize.height + self.headerHeight)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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
        let alert = UIAlertController(title: "اختر اسم الدولة وعام السفر", message: nil, preferredStyle: .alert)
        alert.setTint(color: UIColor.appMango)
        alert.setBackgroudColor(color: UIColor.appVeryLightGray)
        alert.addTextField { (textField) -> Void in
            textField.textColor = UIColor.appVeryLightGray
            textField.placeholder = "الدولة-السنة"
            textField.textColor = UIColor.black
            textField.font = UIFont.appRegularFontWith(size: 14)
        }
        let add = UIAlertAction(title: "تم", style: .default, handler: { [weak self , unowned alert] _ in
            guard let self = self else { return }
            let text = alert.textFields?.first!.text ?? ""
   
            let regex = try! NSRegularExpression(pattern: "[a-z]*[-][0-9]{4}")

            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            if results.count > 0{
                
                self.items.append(text)
                self.countries.onNext(self.items)

            }else{
                alert.message = "ادخل الصيغه الصحيحه"
            }
          
        })

        let cancel = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        alert.addAction(add)

        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
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
