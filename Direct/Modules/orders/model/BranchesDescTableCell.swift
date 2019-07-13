//
//  BranchesDescTableCell.swift
//  Direct
//
//  Created by abuzeid on 7/13/19.
//  Copyright © 2019 abuzeid. All rights reserved.
//

import RxSwift
import UIKit

class BranchesDescTableCell: UITableViewCell, TableCell {
    typealias CellDataModel = BranchesSection
    static var cellId: String = "BranchesDescTableCell"
    @IBOutlet private var addressLbl: UILabel!
    @IBOutlet private var workingTimeLbl: UILabel!
    @IBOutlet private var locationLbl: UILabel!
    private var disposeBag = DisposeBag()
    func setCellData(_ model: CellDataModel) {
        addressLbl.text = model.data.address?.html2String ?? ""
        workingTimeLbl.text = model.data.bhours ?? ""
        locationLbl.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { _ in
                self.openUrl(lat: model.data.lat?.double(), long: model.data.longt?.double())
            }).disposed(by: disposeBag)
    }

    func openUrl(lat: Double?, long: Double?) {}

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
